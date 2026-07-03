# Starship
eval "$(starship init zsh)"

# History settings
HISTFILE=~/.histfile
HISTDUP=erase
HISTSIZE=5000
SAVEHIST=5000

# Options
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

# Keybinds
bindkey -e
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward

# The following lines were added by compinstall
zstyle :compinstall filename '/home/loukas/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Sourcing aliases and plugin "manager"
source ~/.aliases
source ~/.config/zsh/zsh-functions

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Autosuggest config
bindkey '^y' autosuggest-accept

# Jump
eval "$(zoxide init --cmd cd zsh)"

# Fzf
source <(fzf --zsh)


# Add ~/.local/bin to path
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Edit command with editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
