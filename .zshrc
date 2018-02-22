# Source Prezto first, so our settings override theirs
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# alias tips: https://github.com/djui/alias-tips
# This might be majorly slowing down my terminal.
# source alias-tips/alias-tips.plugin.zsh

# Set iterm2 title bar, RGB
# Current theme: Snazzy
echo -e "\033]6;1;bg;red;brightness;40\a"
echo -e "\033]6;1;bg;green;brightness;42\a"
echo -e "\033]6;1;bg;blue;brightness;54\a"
DISABLE_AUTO_TITLE="true"

# MySQL bullshit aliases
alias mysql-stop='sudo /usr/local/mysql/support-files/mysql.server stop'
export PATH="/usr/local/mysql/bin:$PATH"

# Rust
export PATH="/Users/eric/.cargo/bin:$PATH"
function clippy {
    pkgname=$(basename $PWD)
    if [ ! -f Cargo.toml ]
    then
        echo "No Cargo.toml found. Run from crate root."
        return
    fi
    cargo clean -p $pkgname && cargo clippy
}

# exa / ls aliases
# requires exa (brew install exa)
alias ls='exa'
alias l='exa'

# general OS aliases
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias copy="tr -d '\n' | pbcopy"
alias py="python3"

# Python
alias avenv='source env/bin/activate'

# temporary C++ alias
function cprun () {
    g++ -std=c++14 "$@" && ./a.out && rm a.out
    return 0
}

function crun () {
    clang "$@" && ./a.out
    return 0
}

alias cling='/Users/eric/cling/cling-build/builddir/bin/cling'

# git aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gb='git branch'
alias gch='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias git-count='git ls-files | xargs wc -l'

# legit aliases
# install from repo (pypi is outdated) and  allow_black_background=False
# Mostly using this for "legit switch" (auto git stash / checkout / pop )
alias gsw='git switch' 

# requires git aware prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# requires fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf='fzf --preview="cat {}" --preview-window=right:50%:wrap | tee >(copy)'

# requires autojump: https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

