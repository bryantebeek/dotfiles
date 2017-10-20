# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Z
test -e "/usr/local/etc/profile.d/z.sh" && source "/usr/local/etc/profile.d/z.sh"

# Oh-My-Zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bryantebeek"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git, vi-mode, zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Split up path, exports and aliases
for file in ~/.{path,exports,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

eval $(thefuck --alias)
