ZSH=$HOME/.oh-my-zsh

# List of plugins used
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh


# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

# Aliases
source $HOME/shell/aliases

# neofetch
uwufetch

#Display Pokemon
#pokemon-colorscripts --no-title -r 1,3,6

eval "$(starship init zsh)"
