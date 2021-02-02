zmodload zsh/zprof
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


setup_silent_login() {
    touch ~/.hushlogin
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
        # "activate_virtualenv"
        "cd_ls"
    )
}


# Set iTerm2 menubar color.
#
# For the Snazzy theme.
# setup_iterm2_menubar() {
#     echo -n -e "\033]6;1;bg;red;brightness;40\a"
#     echo -n -e "\033]6;1;bg;green;brightness;42\a"
#     echo -n -e "\033]6;1;bg;blue;brightness;54\a"
#     export DISABLE_AUTO_TITLE="true"
# }


# General aliases for navigation.
#
# Required:
#   - exa (https://github.com/ogham/exa): brew install exa
aliases_general() {
    # Navigation
    alias ls='exa'
    alias l='exa'
    alias lsn='ls -snew'
    alias tree='ls -T'
    alias hg='history -1000 | ag'  # TODO: be smarter about getting the line count

    # Clipboard
    alias copy="tr -d '\n' | pbcopy"
    alias cpwd="pwd | copy"
    alias cb="git rev-parse --abbrev-ref HEAD | copy"

    # Editing
    # alias v="vim"
    alias cat="bat"

    alias vimrc="modify_and_source_rcfile ~/.vimrc"
    alias zshrc="modify_and_source_rcfile ~/.zshrc"

    # Languages
    alias py="python3"
    alias delete-images="docker image list | 'fzf' -m | awk '{print $3}' | xargs docker image rm --force"

    # Docker
    alias drun="docker run -it --entrypoint /bin/bash"
}


# Open a file for modification, then source it once closed.
#
# Args:
#   - $1: Path to the file to be modified.
function modify_and_source_rcfile() {
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
    alias gl='git log'
    alias gp='git push'

    alias gf='git fetch --no-tags'
    alias gds='git diff --staged'

    alias delete-branches="git branch | 'fzf' -m | xargs git branch -D"
}


# Setup fzf.
#
# Requires:
#   - fzf (https://github.com/junegunn/fzf)
setup_fzf() {
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    alias fzf='fzf --preview="if [ -d {} ]; then; exa {}; else; bat --color=always {}; fi" --preview-window=right:80%:wrap | tee >(copy)'

    # fd is much faster and respects .gitignore
    export FZF_DEFAULT_COMMAND='fd --type f'
}


fzfa() {
    python -c "import os; print '\$CODEZ/{}'.format(os.path.relpath(os.path.abspath('$(fzf)'), '$CODEZ'))" | tee >(copy)
}

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}


# If the input is a directory, cd to it. If it's anything else, copy it to the clipboard.
preview_fzf_match() {
    local fzf_match="$1"
    if [ -d $fzf_match ]; then
        exa $fzf_match
    else
        bat $fzf_match
    fi
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


discworld() {
    local tinfile="/tmp/run.tin"
    echo "#session dm discworld.starturtle.net 23" > $tinfile
    echo "mudpies" >> $tinfile
    echo "echang" >> $tinfile
    tt++ /tmp/run.tin
}


# https://github.com/clvv/fasd
setup_z() {
    alias j="z"
}


jflip() {
    local directory=$PWD

    if [[ $directory == *main* ]]; then
        local test_dir="${directory/main/test}"
        cd $test_dir
    elif [[ $directory == *"test"* ]]; then
        local main_dir="${directory/test/main}"
        cd $main_dir
    else
        echo "Not in a Java package directory."
    fi
}


use_async_suggestions() {
    # https://github.com/zsh-users/zsh-autosuggestions/issues/234
    export ZSH_AUTOSUGGEST_USE_ASYNC=1
}


main() {
    setup_prezto
    setup_path_modifications
    # add_term_colors
    use_async_suggestions

    aliases_git
    aliases_general

    setup_zsh_hooks
    # setup_iterm2_menubar
    setup_silent_login
    setup_fzf
    setup_z

    if [ -f ~/.zshrc-asana ]; then
        source ~/.zshrc-asana
        source ~/.profile
    else;
        echo "no .zshrc-asana found. remove these lines."
    fi

}


main

