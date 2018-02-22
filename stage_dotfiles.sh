#!/bin/bash

# Copy my dotfiles from home to this directory. Better than symlinks.
# Ignore these files
IGNORE=('.git' '.' '..')

function ignored() {
    for i in "${IGNORE[@]}"; do
        if [[ "$1" == "$i" ]]; then
            return 0
        fi
    done
    return 1
}

function is_tracked {
    git ls-files --error-unmatch "$1"
}

for f in .*; do
    fpath="$HOME/$f"
    if ignored $f; then  # use the exit code of the function directly
        continue
    elif [[ -f $fpath ]]; then
        echo "Copying: ~/$f"
        cp "$fpath" "$f"
    else
        echo "Not found: $f"
    fi
done

git add .
