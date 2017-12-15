# added by Anaconda3 4.3.1 installer
export PATH="/Users/eric/anaconda/bin:$PATH"
export SCALA_HOME="/usr/local/opt/scala/idea"

source ~/git-completion.bash

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\w \$ "

# misc 
alias l='ls'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias copy="tr -d '\n' | pbcopy"

# git aliases
alias ga='git add'
alias gs='git status'
alias gb='git branch'
alias gch='git checkout'

# requires fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash  # requires $(brew --prefix)/opt/fzf/install
alias fzf='fzf --preview="ccat {}" --preview-window=right:50%:wrap | tee >(copy)'

# requires autojump: https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
