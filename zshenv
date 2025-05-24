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
    while [[ "$cwd" != "$HOME" ]] && [[ "$cwd" != "/" ]]; do
        venv=""
        if [ -d "venv" ]; then
            venv="venv"
        elif [ -d ".venv" ]; then
            venv=".venv"
        fi
        if [ -n "$venv" ]; then
            source "$venv/bin/activate" ; break
        else
            cd -q .. ; cwd="$(pwd)"
        fi
    done
    if ([[ "$cwd" = "$HOME" ]] || [[ "$cwd" = "/" ]]) && [[ "${VIRTUAL_ENV:-x}" != "x" ]] && command -v deactivate >/dev/null ; then
        deactivate
    fi
    cd -q "$swd"
}
