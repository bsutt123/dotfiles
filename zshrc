#
# Executes commands at the start of an interactive session.
#
# Authors:
#
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# use VIM mode in terminal

bindkey -v

# Aliases
alias tas="tmux attach-session -t"
alias tls="tmux list-session"

alias mux="tmuxinator"

alias szsh="source ~/.zshrc"

# Add gettext to the path for nvim
export PATH="/usr/local/opt/gettext/bin:$PATH"

# needed for qt5.5 to have the things it needs
export PATH="$(brew --prefix qt@5.5)/bin:$PATH"

# Powerlevel9k Changes
DEFAULT_USER="$USER"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Shorten the directory slightly
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# Shorten the VCS display
POWERLEVEL9K_VCS_SHORTEN_LENGTH=10
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=18
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_DELIMITER=".."

# avoid that weird ass ^M bug
stty icrnl

# unset nomatch for rails [] compatibility
unsetopt nomatch

# NVM initialization
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rbenv initialization
eval "$(rbenv init -)"

# add function to rename panes
export FPATH="$HOME/.zfuncs:$FPATH"
autoload -Uz renamePane
autoload -Uz killPort
autoload -Uz db_reset
autoload -Uz killruby

# fzf installation
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag -g ""'

source ~/dotfiles/tmuxinator/tmuxinator.zsh
