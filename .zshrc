# Following this style guide: https://github.com/progrium/bashstyle
#
# Profiling .zshrc:
#   - Add to top of .zshrc: "zmodload zsh/zprof"
#   - Run in shell:  zprof

# zmodload zsh/zprof


# Source Prezto config.
#
# Run this first so our settings override any presets.
setup_prezto() {
    if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
        source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    fi
}


# Add directories to PATH.
setup_path_modifications() {
    # Haskell
    export PATH="/Users/eric/.local/bin:$PATH"  # Haskell Ide Engine
    export PATH="$HOME/Library/Haskell/bin:$PATH"  # Cabal binaries

    # Rust
    export PATH="/Users/eric/.cargo/bin:$PATH"

    # Python
    # export PATH="/usr/local/Cellar/python/3.6.4/bin:$PATH"  # Homebrew broke Python
}


# Use tput to set terminal color codes for pretty printing.
#
# From http://mywiki.wooledge.org/BashFAQ/037.
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


# Pretty print an autocommand notification.
#
# Args:
#   $1 - The notification to print as a string.
#
# Example:
#   autocmd_notification "This is a notification"
autocmd_notification() {
    echo -n "$magenta$bold"
    echo -n "[AUTO] "
    echo "$1"
    echo -n "$reset"
}


# Automatically activate Python virtualenvs.
#
# Check for env/bin/activate, and activate the virtual environment if it
# exists in the current directory.
activate_virtualenv() {
    if [[ -e "env/bin/activate" ]]; then
        autocmd_notification "Activated virtualenv: $(dirs -c; dirs)/env"
        source env/bin/activate
    fi
}

# Automatically activate and switch node versions.
#
# If a .nvmrc exists in the current directory and doesn't match the current version,
# switch with `nvm use`.
activate_nvmrc() {
    current_node_version="$(node --version | tr -d '\n')"
    if [[ -e ".nvmrc" ]]; then
        nvmrc_node_version="$(cat .nvmrc | tr -d '\n')"
        if [[ "$current_node_version" != "$nvmrc_node_version" ]]; then
            autocmd_notification "Switching nvm version: $nvmrc_node_version"
            nvm use < .nvmrc
        fi
    fi
}


# Alias for ls.
#
# For some reason `ls` doesn't work as a zsh hook on its own.
cd_ls() {
    exa
}


# Set up ZSH hooks / autocommands.
setup_zsh_hooks() {
     # Run after every directory change.
    chpwd_functions=(
        "activate_virtualenv"
        "activate_nvmrc"
        "cd_ls"
    )
}


# Set iTerm2 menubar color.
#
# For the Snazzy theme.
setup_iterm2_menubar() {
    echo -n -e "\033]6;1;bg;red;brightness;40\a"
    echo -n -e "\033]6;1;bg;green;brightness;42\a"
    echo -n -e "\033]6;1;bg;blue;brightness;54\a"
    export DISABLE_AUTO_TITLE="true"
}


# General aliases for navigation.
#
# Required:
#   - exa (https://github.com/ogham/exa): brew install exa
aliases_general() {
    alias ls='exa'
    alias l='exa'
    alias lsn='ls -snew'

    alias copy="tr -d '\n' | pbcopy"
    alias cpwd="pwd | copy"

    alias vimrc="modify_and_source_rcfile ~/.vimrc"
    alias zshrc="modify_and_source_rcfile ~/.zshrc"

    alias py="python3"
}


# Open a file for modification, then source it once closed.
#
# Args:
#   - $1: Path to the file to be modified.
modify_and_source_rcfile() {
    local file_path="$1"
    vim $file_path
    autocmd_notification "Sourcing: $file_path"
    source $file_path
}


# Run howdoi with pretty settings.
#
# Args:
#   - $@: The query for howdoi.
#
# Required:
#   - howdoi (https://github.com/gleitz/howdoi): pip install howdoi
hdi() {
    howdoi $* --color --num-answers 2
};


# setup_ruby() {
#     eval "$(rbenv init -)"
# }


# Git aliases.
aliases_git() {
    alias ga='git add'
    alias gc='git commit'
    alias gs='git status'
    alias gb='git branch'
    alias gch='git checkout'
    alias gd='git diff'
    alias gds='git diff --staged'
    alias gl='git log'
}


# Setup fzf.
#
# Requires:
#   - fzf (https://github.com/junegunn/fzf)
setup_fzf() {
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    alias fzf='fzf --preview="cat {}" --preview-window=right:50%:wrap | tee >(copy)'
}


# Setup autojump.
#
# Requires:
#   - autojump (https://github.com/wting/autojump)
setup_autojump() {
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
}


# Show files (and their line counts) checked into a git repository.
#
# Args:
#   - $1: Pattern for grep.
git-count() {
    git ls-files | grep "$1" | xargs wc -l
}


# Lazily load nvm.
#
# Doing this since it adds > 2 seconds to zsh startup time.
export NVM_LOADED=0
nvm() {
    local nvm_dir="$HOME/.nvm"
    if [[ $NVM_LOADED == 0 ]]; then
        autocmd_notification "Loading nvm..."
        [ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh" # This loads nvm
        export NVM_LOADED=1
    fi
    nvm "$@"  # afterwards, forward all arguments to nvm
}


# Run clippy, a Rust linter.
clippy() {
    local project_name=$(basename $PWD)
    if [ ! -f Cargo.toml ]; then
        echo "No Cargo.toml found. Run from crate root."
        return
    fi
    cargo clean -p $project_name && cargo clippy
}


main() {
    setup_prezto
    setup_path_modifications
    add_term_colors

    aliases_git
    aliases_general

    setup_zsh_hooks
    setup_iterm2_menubar
    setup_fzf
    setup_autojump
}

main
