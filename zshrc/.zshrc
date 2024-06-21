# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="david"
DISABLE_AUTO_UPDATE="true"

# Dracula theme
source ~/.config/zshrc/.omz-theme-dracula

# Aliases
source ~/.config/zshrc/.zsh_aliases

# Functions
source ~/.config/zshrc/.zsh_functions

# Oh my Zsh
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# NodeJS version manager
source /usr/share/nvm/init-nvm.sh

plugins=(git)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vi'
   export TERM=xterm-256color
 else
   export EDITOR='helix'
 fi

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

eval "$(zoxide init zsh)"
