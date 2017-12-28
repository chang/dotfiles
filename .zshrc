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
alias l='ls'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias copy="tr -d '\n' | pbcopy"

# git aliases
alias ga='git add'
alias gs='git status'
alias gb='git branch'
alias gch='git checkout'

# requires git aware prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# requires fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf='fzf --preview="cat {}" --preview-window=right:50%:wrap | tee >(copy)'

# requires autojump: https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
