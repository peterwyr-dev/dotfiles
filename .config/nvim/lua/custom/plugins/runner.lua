local runner_buf

local function quote(value) return vim.fn.shellescape(value) end

local function compile_and_run(compiler, file, suffix)
  local output = vim.fn.tempname() .. (suffix or '')
  return ('%s %s -o %s && %s; status=$?; rm -f %s; exit $status'):format(compiler, quote(file), quote(output), quote(output), quote(output))
end

local runners = {
  c = function(file) return compile_and_run('cc', file) end,
  cpp = function(file) return compile_and_run('c++', file) end,
  c3 = function(file) return 'c3c compile-run ' .. quote(file) end,
  python = function(file) return 'python3 ' .. quote(file) end,
  java = function(file) return 'java ' .. quote(file) end,
  scala = function(file)
    local path = quote(file)
    return ('if command -v scala-cli >/dev/null 2>&1; then scala-cli run %s; else scala %s; fi'):format(path, path)
  end,
  go = function(file) return 'go run ' .. quote(file) end,
  rust = function(file) return compile_and_run('rustc', file) end,
  javascript = function(file) return 'node ' .. quote(file) end,
  javascriptreact = function(file) return 'npx --yes tsx ' .. quote(file) end,
  typescript = function(file) return 'npx --yes tsx ' .. quote(file) end,
  typescriptreact = function(file) return 'npx --yes tsx ' .. quote(file) end,
  kotlin = function(file)
    local output = vim.fn.tempname() .. '.jar'
    return ('kotlinc %s -include-runtime -d %s && java -jar %s; status=$?; rm -f %s; exit $status'):format(
      quote(file),
      quote(output),
      quote(output),
      quote(output)
    )
  end,
  zig = function(file) return 'zig run ' .. quote(file) end,
}

local function open_runner(command, cwd)
  if runner_buf and vim.api.nvim_buf_is_valid(runner_buf) then vim.api.nvim_buf_delete(runner_buf, { force = true }) end

  local height = math.min(12, math.max(1, vim.o.lines - 4))
  vim.cmd(('botright %dnew'):format(height))
  runner_buf = vim.api.nvim_get_current_buf()
  local buf = runner_buf
  vim.bo[buf].bufhidden = 'wipe'
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = 'no'

  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
  end, { buffer = buf, desc = 'Close code runner' })

  local job = vim.fn.termopen(command, { cwd = cwd })
  if job <= 0 then
    vim.notify('Failed to start code runner', vim.log.levels.ERROR)
    vim.api.nvim_buf_delete(buf, { force = true })
    return
  end

  vim.cmd.startinsert()
end

local function current_source()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == '' then
    vim.notify('Save the file before running it', vim.log.levels.WARN)
    return
  end

  local saved, err = pcall(vim.cmd, 'silent write')
  if not saved then
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  return file, vim.bo[buf].filetype
end

local function run_current_file()
  local file, filetype = current_source()
  if not file then return end

  local runner = runners[filetype]
  if not runner then
    vim.notify('No runner for filetype: ' .. filetype, vim.log.levels.WARN)
    return
  end

  open_runner(runner(file), vim.fs.dirname(file))
end

local project_markers = {
  c = { 'CMakeLists.txt' },
  cpp = { 'CMakeLists.txt' },
  c3 = { 'project.json' },
  python = { 'pyproject.toml', 'pytest.ini', 'setup.cfg', 'tox.ini' },
  java = { 'pom.xml', 'build.gradle', 'build.gradle.kts' },
  scala = { 'build.sbt' },
  go = { 'go.mod' },
  rust = { 'Cargo.toml' },
  javascript = { 'package.json' },
  javascriptreact = { 'package.json' },
  typescript = { 'package.json' },
  typescriptreact = { 'package.json' },
  kotlin = { 'build.gradle', 'build.gradle.kts', 'pom.xml' },
  zig = { 'build.zig' },
}

local function node_test_command(root)
  if vim.uv.fs_stat(vim.fs.joinpath(root, 'bun.lock')) or vim.uv.fs_stat(vim.fs.joinpath(root, 'bun.lockb')) then return 'bun test' end
  if vim.uv.fs_stat(vim.fs.joinpath(root, 'pnpm-lock.yaml')) then return 'pnpm test' end
  if vim.uv.fs_stat(vim.fs.joinpath(root, 'yarn.lock')) then return 'yarn test' end
  return 'npm test'
end

local function gradle_test_command(root)
  if vim.uv.fs_stat(vim.fs.joinpath(root, 'gradlew')) then return './gradlew test' end
  return 'gradle test'
end

local project_tests = {
  ['CMakeLists.txt'] = function() return 'ctest --test-dir build --output-on-failure' end,
  ['project.json'] = function() return 'c3c test' end,
  ['pyproject.toml'] = function() return 'python3 -m pytest' end,
  ['pytest.ini'] = function() return 'python3 -m pytest' end,
  ['setup.cfg'] = function() return 'python3 -m pytest' end,
  ['tox.ini'] = function() return 'python3 -m pytest' end,
  ['pom.xml'] = function() return 'mvn test' end,
  ['build.gradle'] = gradle_test_command,
  ['build.gradle.kts'] = gradle_test_command,
  ['build.sbt'] = function() return 'sbt test' end,
  ['go.mod'] = function() return 'go test ./...' end,
  ['Cargo.toml'] = function() return 'cargo test' end,
  ['package.json'] = node_test_command,
  ['build.zig'] = function() return 'zig build test' end,
}

local fallback_tests = {
  c3 = function(file) return 'c3c compile-test ' .. quote(file) end,
  python = function(file) return 'python3 -m pytest ' .. quote(file) end,
  go = function() return 'go test' end,
  rust = function(file) return compile_and_run('rustc --test', file) end,
  javascript = function(file) return 'npx --yes vitest run ' .. quote(file) end,
  javascriptreact = function(file) return 'npx --yes vitest run ' .. quote(file) end,
  typescript = function(file) return 'npx --yes vitest run ' .. quote(file) end,
  typescriptreact = function(file) return 'npx --yes vitest run ' .. quote(file) end,
  scala = function(file) return 'scala-cli test ' .. quote(file) end,
  zig = function(file) return 'zig test ' .. quote(file) end,
}

local function test_current_project()
  local file, filetype = current_source()
  if not file then return end

  local markers = project_markers[filetype]
  local marker = markers and vim.fs.find(markers, { path = vim.fs.dirname(file), upward = true, type = 'file' })[1]
  if marker then
    local root = vim.fs.dirname(marker)
    open_runner(project_tests[vim.fs.basename(marker)](root), root)
    return
  end

  local test = fallback_tests[filetype]
  if not test then
    vim.notify('No automatic test command for filetype: ' .. filetype, vim.log.levels.WARN)
    return
  end

  open_runner(test(file), vim.fs.dirname(file))
end

vim.keymap.set('n', '<leader>rr', run_current_file, { desc = '[R]un current file' })
vim.keymap.set('n', '<leader>rt', test_current_project, { desc = '[R]un [T]ests' })
