# Homebrew broke python3
# export PATH="/usr/local/Cellar/python/3.6.4/bin:$PATH"

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

# Rust
export PATH="/Users/eric/.cargo/bin:$PATH"
alias ct="cargo test"
function clippy {
    pkgname=$(basename $PWD)
    if [ ! -f Cargo.toml ]; then
        echo "No Cargo.toml found. Run from crate root."
        return
    fi
    cargo clean -p $pkgname && cargo clippy
}



# kcov (Code coverage for compiled binaries)
export PATH="/Users/eric/kcov_build/kcov/src/Release:$PATH"

# exa / ls aliases
# requires exa (brew install exa)
alias ls='exa'
alias l='exa'
alias lsn='ls -snew'

# transfer.sh
transfer() {
    if [ $# -eq 0 ]; then
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1
    fi
    tmpfile=$( mktemp -t transferXXX )
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
    fi
    cat $tmpfile
    rm -f $tmpfile
    printf "\n"  # Print a newline so the Prezto Pure theme doesn't eat the URL.
}


# general OS aliases
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias copy="tr -d '\n' | pbcopy"
alias cpwd="pwd | copy"
alias py="python3"

# Python
alias avenv='source env/bin/activate'

# Ruby
eval "$(rbenv init -)"

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


# added by travis gem
[ -f /Users/eric/.travis/travis.sh ] && source /Users/eric/.travis/travis.sh
