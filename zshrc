#zmodload zsh/zprof # uncomment for zsh profiling
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    path=("$HOME/.local/bin" $path)
    export PATH
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xxf" # set by `omz`

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#DISABLE_UNTRACKED_FILES_DIRTY="true"

# Use shared history across sessions
setopt sharehistory

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"
HIST_FIND_NO_DUPS="true"
HIST_IGNORE_ALL_DUPS="true"
HIST_SAVE_NO_DUPS="true"
HIST_IGNORE_SPACE="true"

# disable lesshst
export LESSHISTFILE="-"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export ZSH_AUTOSUGGEST_STRATEGY=("history")

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgrep.conf"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude .git --exclude .vim --color=always"
export FZF_DEFAULT_OPTS="--ansi"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# always use base clang configuration
clang () { $(which clang) --config "$HOME/.config/clang/clang.cfg" $@ }

# check for and activate python3 venv after each cd
chpwd_functions=( try_activate )

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    zsh-autosuggestions
    colored-man-pages
    fd
    ripgrep
    safe-paste
)

# add custom completion paths for brew and user
if [ -d "/opt/homebrew/share/zsh/site-functions" ] ; then
    fpath=("/opt/homebrew/share/zsh/site-functions" $fpath)
    export FPATH
fi
if [ -d "$HOME/.local/completions" ] ; then
    fpath=("$HOME/.local/completions" $fpath)
    export FPATH
fi
if [ -d "$HOME/.go/bin" ] ; then
    PATH="$PATH:$HOME/.go/bin"
    export PATH
fi

# disable some random dir-related aliases omz tries to add (mostly bc it calls compinit)
zstyle ':omz:directories' aliases no
# load omz and plugins
source $ZSH/oh-my-zsh.sh

# custom aliases
alias a='alpine'
alias python='python3'
alias grep='rg'
alias find='fd'
alias dc='cd'
alias gs='git status'
alias gb='git branch -a'
alias gc='git commit'
alias gp='git push'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ls='exa'
alias la='exa -a'
alias ll='exa -l@ --git'
alias exa='exa -F --group-directories-first --color-scale --color=automatic'
alias gl='git log --name-status --pretty=full | view -'
alias wim='vim ~/.vimwiki/index.md'

#zprof # uncomment for startup profiling
