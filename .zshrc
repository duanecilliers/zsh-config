# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# ZSH equivalent of reverse search
bindkey "^R" history-incremental-search-backward

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases if existent.
[ -f "$HOME/.config/zsh/.aliases" ] && source "$HOME/.config/zsh/.aliases"

# Load custom paths
[ -f "$HOME/.config/zsh/.paths" ] && source "$HOME/.config/zsh/.paths"

# Load .extra file if existent. Useful for adhoc additions
[ -f "$HOME/.config/zsh/.extra" ] && source "$HOME/.config/zsh/.extra"

# Load zsh-syntax-highlighting; should be last.
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

source /opt/homebrew/Cellar/antidote/1.9.10/share/antidote/antidote.zsh

antidote load

# antidote - https://antidote.sh/
source <(antidote init)

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
antidote bundle zsh-users/zsh-syntax-highlighting
