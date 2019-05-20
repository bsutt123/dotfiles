#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Customize to your needs...

# Powerlevel9k Changes

DEFAULT_USER="$USER"

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# initialize rbenv
eval "$(rbenv init -)"

# initialize nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# add function to rename panes
export FPATH="$HOME/.zfuncs:$FPATH"
autoload -Uz renamePane
autoload -Uz killPort

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag -g ""'

alias ag="ag --path-to-ignore ~/.ignore"

source ~/.bin/tmuxinator.zsh
