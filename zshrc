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
zstyle ':completion:*' menu select

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
export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude .git --exclude .vim --color always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_ALT_C_COMMAND=""
export FZF_CTRL_T_COMMAND=""
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# always use base clang configuration
clang () { /usr/bin/clang --config "$HOME/.config/clang/clang.cfg" $@ }

# check for and activate python3 venv after each cd
chpwd_functions=( try_activate )

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    colored-man-pages
    safe-paste
    z
)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# post-source key bindings
function fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^R'   fzf-history-widget-accept
bindkey -r '^T'  # remove fzf ctrl-t
bindkey -r '^[c' # and escape-c

# custom aliases
alias u='update'
alias vim='nvim'
alias python='python3'
alias grep='rg'
alias find='fd'
alias dc='cd'
alias gs='git status'
alias gp='git push'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ls='eza'
alias la='eza -a'
alias ll='eza -l@ --git'
alias eza='eza -F --group-directories-first --color=automatic'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

function ssh-add() {
    /usr/bin/ssh-add --apple-use-keychain $@
}
ssh-add --apple-load-keychain ~/.ssh/*_ed25519 ~/.ssh/*_ecdsa >/dev/null 2>&1 &|

uvshebang='#!/usr/bin/env -S uv run --script
# /// script
# dependencies = []
# ///'

function uvpkg() {
if [[ -z "$1" ]] || [[ ! -f "$1" ]] ; then echo "Usage: uvpkg <python file>" >&2 ; return 1
else mv "$1" "$1.bak" && echo "$uvshebang" > "$1" && cat "$1.bak" >> "$1" && rm -f "$1.bak"
fi
}

# disable lesshst
export LESSHISTFILE=/dev/null

#zprof # uncomment for startup profiling
