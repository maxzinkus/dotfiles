# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic" # set by `omz`

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

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export ZSH_AUTOSUGGEST_STRATEGY=("history")

# Ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgrep.conf"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
# rustup and cargo are really slow!
plugins=(
    zsh-autosuggestions
    colored-man-pages
    fd
    ripgrep
    safe-paste
)

source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git --exclude .vim --color=always"
export FZF_DEFAULT_OPTS="--ansi"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

alias python='python3'
alias grep='rg'
alias find='fd'
alias dc='cd'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ls='exa'
alias la='exa -a'
alias ll='exa -l@ --git'
alias exa='exa -F --group-directories-first --color-scale --color=automatic'
alias wim='vim ~/.vimwiki/index.md'
function clang() {
    $(which -a clang | tail -n 1) --config ~/.config/clang/clang.cfg $@
}

export MANPATH="/usr/local/man:$MANPATH"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
autoload -Uz compinit
compinit
