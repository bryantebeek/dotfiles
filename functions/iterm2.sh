function iterm2SetBadge() {
    printf "\e]1337;SetBadgeFormat=%s\a" $(echo "$@" | base64)
}

function iterm2SwitchProfile() {
    echo -e "\033]50;SetProfile=$1\a"
}

function iterm2SwitchDefaultProfile() {
    echo -e "\033]50;SetProfile=$ITERM2_DEFAULT_PROFILE\a"
}
