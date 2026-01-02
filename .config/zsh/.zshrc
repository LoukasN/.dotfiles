# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi	

# History settings
HISTFILE=~/.histfile
HISTDUP=erase
HISTSIZE=5000
SAVEHIST=5000

# Options
setopt autocd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_ignore_space

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
source ~/GitApps/powerlevel10k/powerlevel10k.zsh-theme

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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Yazi changes directories
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Edit command with editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
