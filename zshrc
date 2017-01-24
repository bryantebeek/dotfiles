# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

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

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

# Enable PHP 7
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
export PATH="/Users/bryantebeek/.composer/vendor/bin:$PATH"

# Enable sonar-scanner
export PATH="/Users/bryantebeek/.sonar-scanner/bin:$PATH"
