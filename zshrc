# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Z
test -e "/usr/local/etc/profile.d/z.sh" && source "/usr/local/etc/profile.d/z.sh"

# ZSH Plugins
test -e "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" && source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
test -e "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Oh-My-Zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="spaceship"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
SPACESHIP_KUBECONTEXT_SHOW="false"
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

# Autocomplete Teamocil
compctl -g '~/.teamocil/*(:t:r)' teamocil
fpath=($fpath "/Users/bryantebeek/.zfunctions")
fpath=($fpath "/Users/bryantebeek/.zfunctions")
export PATH="/usr/local/opt/gettext/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bryantebeek/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bryantebeek/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bryantebeek/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bryantebeek/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
