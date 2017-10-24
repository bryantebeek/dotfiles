function searchHostsFromKnownHosts() {
    echo $(ssh-keygen -l -f ~/.ssh/known_hosts | cut -d" " -f3 | cut -d"," -f1 | grep -ov '^[0-9]\+\.' | fzf --header=Servers)
}

function sshFromSearchHosts() {
    local HOST=$(searchHostsFromKnownHosts)
    local USER=root
    vared -p "User for $SERVER: " -c USER
    sshAndSwitchProfile $USER@$SERVER
}

function sshAndSwitchProfile() {
    local REMOTE_HOSTNAME=$(command ssh "$@" "hostname")

    if [[ $REMOTE_HOSTNAME == *"prod"* ]]; then
        iterm2SwitchProfile "Server Production"
    else
        iterm2SwitchProfile "Server"
    fi

    command ssh $@
    iterm2SwitchDefaultProfile
}
