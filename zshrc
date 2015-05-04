# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Oh-My-Zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git, zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Use z for easy navigation
. `brew --prefix`/etc/profile.d/z.sh
