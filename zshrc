# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Oh-My-Zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bryantebeek"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git, vi-mode, zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Use z for easy navigation
. `brew --prefix`/etc/profile.d/z.sh

# ZSH Syntax Highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
