# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Z
test -e "/usr/local/etc/profile.d/z.sh" && source "/usr/local/etc/profile.d/z.sh"

# Oh-My-Zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="spaceship"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git, vi-mode, zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Load exports
source ~/.exports

# Load functions configuration
source ~/.functions/config.sh

# Load all functions
source ~/.functions/iterm2.sh
source ~/.functions/filesystem.sh
source ~/.functions/ssh.sh
source ~/.functions/watch.sh

# Load aliases (these can alias a function)
source ~/.aliases

  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship
