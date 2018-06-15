# Source Prezto first, so our settings override theirs
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Color
# function contents via http://mywiki.wooledge.org/BashFAQ/037
add_term_colors() {
    # only set if we're on an interactive session
    [[ -t 2 ]] && {
        reset=$(    tput sgr0   || tput me      ) # Reset cursor
        bold=$(     tput bold   || tput md      ) # Start bold
        default=$(  tput op                     )
        back=$'\b'

        [[ $TERM != *-m ]] && {
            red=$(      tput setaf 1 || tput AF 1    )
            green=$(    tput setaf 2 || tput AF 2    )
            yellow=$(   tput setaf 3 || tput AF 3    )
            blue=$(     tput setaf 4 || tput AF 4    )
            magenta=$(  tput setaf 5 || tput AF 5    )
            cyan=$(     tput setaf 6 || tput AF 6    )
            white=$(    tput setaf 7 || tput AF 7    )
        }
    } 2>/dev/null ||:
}

add_term_colors


## zsh hooks
# run these functions after every cd
chpwd_functions=("activate_virtualenv" "activate_nvmrc" "cd_ls")

function print_yellow_bold {
        echo -n "$yellow$bold"
        echo -n "[AUTO] "
        echo "$1"
        echo -n "$reset"
}

function activate_virtualenv() {  
    if [[ -e "env/bin/activate" ]]; then
        print_yellow_bold "Activated virtualenv: $(dirs -c; dirs)/env"
        source env/bin/activate
    fi
}

function activate_nvmrc() {  
    if [[ -e ".nvmrc" ]]; then
        print_yellow_bold "Switching nvm version: $(cat .nvmrc)"  
        nvm use < .nvmrc
    fi
}

# for some reason this needs to be declared as a function
function cd_ls() {
    ls
}

# Node
# Lazily load nvm since it adds > 2 seconds to zsh startup time.
export NVM_DIR="$HOME/.nvm"
export NVM_LOADED=0
function nvm() {
    if [[ $NVM_LOADED == 0 ]]; then
        print_yellow_bold "Loading nvm..."
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        export NVM_LOADED=1
    fi
    nvm $@  # afterwards, forward all arguments to nvm
}

# Current theme: Snazzy - iTerm2 color escape codes
echo -e "\033]6;1;bg;red;brightness;40\a"
echo -e "\033]6;1;bg;green;brightness;42\a"
echo -e "\033]6;1;bg;blue;brightness;54\a"
DISABLE_AUTO_TITLE="true"

# Haskell
export PATH="/Users/eric/.local/bin:$PATH"  # Haskell language server is kept here
export PATH="$HOME/Library/Haskell/bin:$PATH"  # cabal binaries here

# Rust
export PATH="/Users/eric/.cargo/bin:$PATH"
function clippy {
    pkgname=$(basename $PWD)
    if [ ! -f Cargo.toml ]; then
        echo "No Cargo.toml found. Run from crate root."
        return
    fi
    cargo clean -p $pkgname && cargo clippy
}


# Racket
export PATH="/Applications/Racket v6.12/bin:$PATH"

# exa / ls aliases (brew install exa)
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


# general aliases
alias copy="tr -d '\n' | pbcopy"
alias cpwd="pwd | copy"
alias py="python3"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
function hdi(){ howdoi $* --color --num-answers 2; };


# Ruby
eval "$(rbenv init -)"

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
# brings up results in a window with previewing
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf='fzf --preview="cat {}" --preview-window=right:50%:wrap | tee >(copy)'

# requires autojump: https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# added by travis gem
[ -f /Users/eric/.travis/travis.sh ] && source /Users/eric/.travis/travis.sh

# source /Users/eric/Documents/alias-tips/alias-tips.plugin.zsh
# Homebrew broke python3
# export PATH="/usr/local/Cellar/python/3.6.4/bin:$PATH"

