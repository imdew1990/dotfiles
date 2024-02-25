
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(starship init bash)"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
