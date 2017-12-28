# added by Anaconda3 4.3.1 installer

export SCALA_HOME="/usr/local/opt/scala/idea"
export PYTHONPATH="${PYTHONPATH}:/Users/eric/Documents/subreddit_recommender"

source ~/git-completion.bash

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\w \$ "

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
export PS1="\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# requires fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash  # requires $(brew --prefix)/opt/fzf/install
alias fzf='fzf --preview="cat {}" --preview-window=right:50%:wrap | tee >(copy)'

# requires autojump: https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
