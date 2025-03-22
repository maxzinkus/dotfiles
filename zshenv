export SHELL_SESSIONS_DISABLE=1 # disable macOS shared history -> setopt sharehistory in .zshrc instead
export TERM="xterm-256color"
export EDITOR="nvim"

export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

export ICLOUD_DRIVE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

export MANPATH="/usr/local/man:$MANPATH"

export GOPATH="$HOME/.go"

function try_activate() {
    swd="$(pwd)"
    cwd="$swd"
    while [ "$cwd" != "$HOME" -a "$cwd" != "/" ]
    do if [ -d "venv" ]
        then source venv/bin/activate ; break
        else cd -q .. ; cwd="$(pwd)"
        fi
    done
    if [ "$cwd" = "$HOME" -o "$cwd" = "/" ]
    then if [ "$VIRTUAL_ENV" ]
        then deactivate
        fi
    fi
    cd -q "$swd"
}
