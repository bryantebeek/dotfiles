function fileActions() {
    if [ -z "$1" ]; then return; fi

    local ACTIONS=${2:-$FILESYSTEM_FILE_ACTIONS}
    local KEY=$(echo "$ACTIONS" | cut -d":" -f1 | fzf --header="Actions on $1" --preview "cat '"$1"'")

    if [ -z "$KEY" ]; then return; fi

    local ACTION=$(echo "$ACTIONS" | grep "$KEY" | cut -d":" -f2)
    eval $(echo "$ACTION" | sed "s/<FILE>/$1/g")
}

function directoryActions() {
    if [ -z "$1" ]; then return; fi

    local ACTIONS=${2:-$FILESYSTEM_FILESYSTEM_DIRECTORY_ACTIONS}
    local KEY=$(echo "$ACTIONS" | cut -d":" -f1 | fzf --header="Actions on $1")

    if [ -z "$KEY" ]; then return; fi

    local ACTION=$(echo "$ACTIONS" | grep "$KEY" | cut -d":" -f2)
    eval $(echo "$ACTION""" | sed 's/<DIR>/$1/g')
}

function searchProject() {
    echo $(find ${PROJECT_DIRECTORIES[@]} -type d -maxdepth 1 | fzf --header=Projects)
}

function searchFiles() {
    local SEARCH_DIRECTORY=${1:-$HOME}
    echo $(mdfind 'kMDItemContentType != public.folder' -onlyin "$SEARCH_DIRECTORY" | fzf --header=Files --preview 'cat {}')
}

function searchDirectories() {
    local SEARCH_DIRECTORY=${1:-$HOME}
    echo $(mdfind 'kMDItemContentType == public.folder' -onlyin "$SEARCH_DIRECTORY" | fzf --header=Directories)
}

function searchFilesAndAction() {
    local FILE=$(searchFiles "$1")
    fileActions "$FILE" "$FILESYSTEM_FILE_ACTIONS"
}

function searchDirectoriesAndAction() {
    local DIR=$(searchDirectories "$1")
    directoryActions "$DIR" "$FILESYSTEM_DIRECTORY_ACTIONS"
}

function searchDirectoriesAndCd() {
    local DIR=$(searchDirectories "$1")
    cd "$DIR"
}

function searchProjectAndAction() {
    directoryActions "$(searchProject)" "$FILESYSTEM_DIRECTORY_ACTIONS"
}

function currentDirectoryAndAction() {
    local ACTIONS=$(echo $FILESYSTEM_DIRECTORY_ACTIONS | sed 1d) # This removes the change directory entry, as it's irrelevant
    directoryActions "$PWD" "$ACTIONS"
}
