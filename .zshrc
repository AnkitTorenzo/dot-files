#Adding path to zsh path variable
export PYENV_ROOT="$HOME/.pyenv"
export PATH=/home/linuxbrew/.linuxbrew/bin:/home/ghost/.local/bin:/home/ankit/Android/Sdk/platform-tools:$PATH

#init OMP for zsh
eval "$(oh-my-posh init zsh --config ~/.config/omp/custom.omp.json)"

# Set zinit path.
ZINIT_HOME="${XDH_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

#check and download zinit plugin.
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# source/load zinit
source "$ZINIT_HOME/zinit.zsh"

## installing & using powerlevel 10K.
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

#zinit snipets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found


## auto load auto-compaletion
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## custom key bindings
bindkey '^f' autosuggest-accept
bindkey '^j' history-search-forward
bindkey '^k' history-serach-backward

## History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# zsh auto completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -al --color=always --group-directories-first --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -al --color=always --group-directories-first --icons $realpath'


#shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

## aliaz +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
alias nv='nvim'
alias :q='exit'
alias please='sudo'

# Garuda aliases for 'ls' command
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias lsz='eza -al --color=always --total-size --group-directories-first --icons' # include file size
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.='eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# Common use
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias dir='dir --color=auto'
alias fixpacman='sudo rm /var/lib/pacman/db.lck'
alias grep='ugrep --color=auto'
alias egrep='ugrep -E --color=auto'
alias fgrep='ugrep -F --color=auto'
alias grubup='sudo update-grub'
alias hw='hwinfo --short'                          # Hardware Info
alias ip='ip -color'
alias rmpkg='sudo pacman -Rdd'
alias cp='cp -v'

alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias upd='/usr/bin/garuda-update'
alias vdir='vdir --color=auto'
alias wget='wget -c '
alias zed='zeditor'

## aliases are complete================================================================================================================

if [[ $- == *i* ]]; then
    fastfetch --logo arch
fi

## Open the tmux as the start of zsh
if [ -z "$TMUX" ]; then
  tmux -u attach-session || tmux -u new-session
fi
