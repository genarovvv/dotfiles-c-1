# Author: z1rov
export ZSH_DISABLE_COMPFIX=true

# =========================
# History
# =========================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# =========================
# Powerlevel10k
# =========================
source "$HOME/.powerlevel10k/powerlevel10k.zsh-theme"

# =========================
# Aliases
# =========================
alias cat="batcat --theme='Solarized (dark)'"
alias ls='eza --icons=always --color=always'
alias ll='eza --icons=always --color=always -la'

# =========================
# LS_COLORS
# =========================
LS_COLORS="di=38;2;129;161;193:fi=38;2;216;222;233:ex=38;2;163;190;140:ln=38;2;208;135;112:so=38;2;235;203;139:pi=38;2;180;142;173:bd=38;2;191;97;106:cd=38;2;143;188;187:or=38;2;255;85;85:mi=38;2;255;0;0"
export LS_COLORS

# =========================
# ZSH Autosuggestions
# =========================
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# =========================
# Powerlevel10k Config
# =========================
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# =========================
# Random ASCII
# =========================
ASCII_DIR="$HOME/.config/ascii"
if [[ -d "$ASCII_DIR" ]]; then
    ITEM=$(find "$ASCII_DIR" \( -name "*.txt" -o -name "*.sh" \) 2>/dev/null | shuf -n 1)
    case "$ITEM" in
        *.txt)
            command cat "$ITEM"
            ;;
        *.sh)
            bash "$ITEM"
            ;;
    esac
fi

# =========================
# ZSH Syntax Highlighting
# =========================
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[command]='fg=111,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=147,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=183,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=218,bold'
ZSH_HIGHLIGHT_STYLES[external]='fg=117,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=213,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=245'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=245'
ZSH_HIGHLIGHT_STYLES[arg]='fg=225'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=217,bold'

# =========================
# PATH
# =========================
export PATH="$HOME/.local/bin:$PATH"

# =========================
# History search by current input (estilo oh-my-zsh)
# Ejemplo:
# sou + UP   -> source xxx
# sou + UP   -> source yyy
# sou + DOWN -> source xxx
# =========================
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Usamos terminfo por si tu terminal manda ^[OA en vez de ^[[A
if [[ -n "${terminfo[kcuu1]}" ]]; then
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ -n "${terminfo[kcud1]}" ]]; then
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# Fallback explícito por si terminfo no resuelve bien en tu emulador
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
