# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/user/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"
HIST_FIND_NO_DUPS="true"
HIST_IGNORE_ALL_DUPS="true"
HIST_SAVE_NO_DUPS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  fast-syntax-highlighting  # highlighting commands as I write them?
  zsh-autosuggestions       # suggest last matching command
  forgit                    # beautiful git w/fzf+diff-so-fancy
)

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

ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:/home/user/.local/bin"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# non-interactive in .zshenv
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

export TERM=xterm-256color

export FZF_DEFAULT_COMMAND="fdfind --type file --follow --hidden --exclude .git --exclude .vim --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--ansi --preview '(highlight -l -O ansi {} 2>/dev/null || cat {}) 2>/dev/null'"
export FZF_ALT_C_OPTS="--preview 'ls --color -d {} 2>/dev/null && ls {} 2>/dev/null'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RIPGREP_CONFIG_PATH="/home/user/.config/ripgrep/ripgrep.conf"

# snap applications
alias spotify="snap run spotify -force-device-scale-factor=1.75 >/dev/null 2>&1 &|"

if [ -f ~/.last-update-run ]
then if [ $(date -Idate -r ~/.last-update-run) != $(date -Idate) ] # if we haven't asked today
    then touch ~/.last-update-run
        read -q "REPLY?Would you like to update? [y/N] "
        if [ $REPLY = "y" ]
        then echo "" ; ~/.local/bin/update.zsh
        fi
    fi
fi

bindkey "^p" push-line
bindkey "^o" get-line

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
