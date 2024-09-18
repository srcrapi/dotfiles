export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $HOME/shell/aliases

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/rap1/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

fastfetch
