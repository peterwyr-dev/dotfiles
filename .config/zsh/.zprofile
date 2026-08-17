
# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH





  export HOMEBREW_PIP_INDEX_URL=http://mirrors.aliyun.com/pypi/simple #ckbrew
  export HOMEBREW_API_DOMAIN=https://formulae.brew.sh/api  #ckbrew
  export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles #ckbrew
  eval $(/opt/homebrew/bin/brew shellenv) #ckbrew


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

eval "$(/opt/homebrew/bin/brew shellenv)"

# Use Temurin 25 LTS as the default development JDK.
export JAVA_HOME=$(/usr/libexec/java_home -v 25)
export PATH="$JAVA_HOME/bin:$PATH"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# MATLAB license file (moved from ~/matlab license)
export MLM_LICENSE_FILE="$HOME/Documents/.app-data/matlab license/license.lic"

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"


# Added by Antigravity CLI installer
export PATH="/Users/wangyiran/.local/bin:$PATH"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/wangyiran/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
