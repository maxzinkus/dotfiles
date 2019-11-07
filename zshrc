# Path to your oh-my-zsh installation.
export ZSH="/home/user/.oh-my-zsh"

export TERM=xterm-256color

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80

# Case-sensitive completion.
CASE_SENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

# History options
HIST_STAMPS="dd.mm.yyyy"
HIST_FIND_NO_DUPS="true"
HIST_IGNORE_ALL_DUPS="true"
HIST_SAVE_NO_DUPS="true"

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:/home/user/.local/bin"

# Ripgrep
export RIPGREP_CONFIG_PATH="/home/user/.config/ripgrep/ripgrep.conf"

# fzf
export FZF_DEFAULT_COMMAND="fdfind --type file --follow --hidden --exclude .git --exclude .vim --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--ansi --preview '(highlight -l -O ansi {} 2>/dev/null || cat {}) 2>/dev/null'"
export FZF_ALT_C_OPTS="--preview 'ls --color -d {} 2>/dev/null && ls {} 2>/dev/null'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function fman() {
   man -k . | fzf --prompt='Man> ' --preview "man \$(echo {} | awk '{print \$1}')" | awk '{print $1}' | xargs -r man
}
zle -N fman fman
bindkey "^k" fman

# Plugins
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  fast-syntax-highlighting  # highlighting commands as I write them?
  zsh-autosuggestions       # suggest last matching command
  forgit                    # beautiful git w/fzf+diff-so-fancy
)

# Aliases and bindings
function forgit() { # just in case I... forgit XD
    echo "forgit usage"
    echo "glo   : git log"
    echo "gd    : git diff"
    echo "ga    : git add"
    echo "gi    : gitignore builder"
    echo "gcf   : git checkout"
    echo "gss   : git stash"
    echo "gclean: git clean"
}

# non-interactive loaded aliases in .zshenv
bindkey "^p" push-line
bindkey "^o" get-line
alias dc='cd'
alias grep='rg'
alias x='xdg-open'
alias v='fzf --preview "(highlight -l -O ansi {} 2>/dev/null || cat {}) 2>/dev/null" --bind "enter:execute(vim {})+accept"'
alias ifconfig='ip a'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias sctl='systemctl'
alias fd='fdfind'
alias lsc='ls -1 | wc -l'
alias lsca='ls -A1 | wc -l'
function clang() {
   /usr/bin/clang --config ~/.config/clang/clang.cfg $@
}
function evince() {
    /usr/bin/evince $@ >/dev/null 2>&1 &
}
alias spotify="snap run spotify -force-device-scale-factor=1.75 >/dev/null 2>&1 &|"

# Prompt for updates
if [ -f ~/.last-update-run ]
then if [ $(date -Idate -r ~/.last-update-run) != $(date -Idate) ] # if we haven't asked today
    then touch ~/.last-update-run
        read -q "REPLY?Would you like to update? [y/N] "
        if [ $REPLY = "y" ]
        then echo "" ; ~/.local/bin/update.zsh
        fi
    fi
fi

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
