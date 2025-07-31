# Use this file to configure your fish shell 
source ~/.config/fish/sistem-config.fish

# kitty
alias icat="kitten icat"

# apps
alias vim="nvim"
alias cat="bat"
alias ff="fastfetch"
alias fzf='fzf --preview="bat --color=always {}" --border=rounded'
alias vfzf='nvim $(fzf --preview="bat --color=always {}" --border=rounded)'

# obsidian
alias on="python3 ~/.local/bin/obsidian.py -n"
alias os="python3 ~/.local/bin/obsidian.py -s"
alias op="python3 ~/.local/bin/obsidian.py -p"

