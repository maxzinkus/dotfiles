# Path to your oh-my-zsh installation.
export ZSH="/home/user/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

export TERM=xterm-256color

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export ZSH_AUTOSUGGEST_STRATEGY=("history")

# Case-sensitive completion.
CASE_SENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

# History options
HIST_STAMPS="dd.mm.yyyy"
HIST_FIND_NO_DUPS="true"
HIST_IGNORE_ALL_DUPS="true"
HIST_SAVE_NO_DUPS="true"

export PATH="$PATH:/home/user/.local/bin"

# Ripgrep
export RIPGREP_CONFIG_PATH="/home/user/.config/ripgrep/ripgrep.conf"

# Plugins
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # otherwise forgit complains
plugins=(
  zsh-autosuggestions       # suggest last matching command, fish-style
  fast-syntax-highlighting  # highlighting commands as I write them?
  forgit                    # beautiful git w/fzf+diff-so-fancy
  colored-man-pages         # everything is better with colors
)

# source oh-my-zsh AFTER the plugins are defined, silly
source $ZSH/oh-my-zsh.sh

# fzf
export FZF_DEFAULT_COMMAND="fdfind --type file --follow --hidden --exclude .git --exclude .vim --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--ansi --preview '(highlight -l -O ansi {} 2>/dev/null || cat {}) 2>/dev/null'"
export FZF_ALT_C_OPTS="--preview 'ls --color -d {} 2>/dev/null && ls {} 2>/dev/null'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # sourced again because it doesn't work when sourced before the plugins?

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
function fman() {
   page=$(man -k . | fzf --prompt='Man> ' --preview "man \$(echo {} | awk '{print \$1}')" | awk '{print $1}')
   colored man "$page"
}
zle -N fman fman
bindkey "^k" fman
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
alias ls='exa'
alias ll='exa -lh --git'
alias lsc='exa -1 | wc -l'
alias lsca='exa -1 --all | wc -l'
alias exa='exa -F --color=always'
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
