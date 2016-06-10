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

# Start a Tmux session if none is currently active (useful on startup)
if [ -z "$TMUX" ]; then
    tmux attach -t Default || tmux new -s Default
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"
export PATH="/Users/bryantebeek/.composer/vendor/bin:$PATH"
export PATH="/Users/bryantebeek/Library/Android/sdk/platform-tools:$PATH"
