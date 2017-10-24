function watchUrl() {
    iterm2SetBadge "📈"

	if [ -z "$2" ]; then
		watch --color --no-title "tput setaf 2; echo 'HTTP status:'; tput setaf 7; curl -sLI $1; tput setaf 2; echo 'TOP status:'; tput setaf 7; ssh root@$1 'top -b -n 1 | head'"
	else
    	watch --color --no-title "tput setaf 2; echo 'HTTP status:'; tput setaf 7; curl -sLI $1; tput setaf 2; echo 'TOP status:'; tput setaf 7; ssh root@$1 'top -b -n 1 | head'; tput setaf 2; echo '\nExtra (${@:2}):'; tput setaf 7; ssh root@$1 '${@:2}'"
	fi

    iterm2SetBadge ""
}
