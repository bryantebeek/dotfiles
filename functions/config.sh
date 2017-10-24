export FZF_DEFAULT_OPTS='
    --reverse
    --color=16
'

export ITERM2_DEFAULT_PROFILE="Bryan te Beek"

export PROJECT_DIRECTORIES=(
    "$HOME/"
    "$HOME/Projects"
    "$HOME/Lifely"
    "$HOME/Lifely/Projects"
)

export FILESYSTEM_DIRECTORY_ACTIONS="Change directory:cd <DIR>
Open with Source Tree:open <DIR> -a 'SourceTree'
Open with Visual Studio Code:open <DIR> -a 'Visual Studio Code'
Open with $EDITOR:$EDITOR <DIR>"

export FILESYSTEM_FILE_ACTIONS="Open:open <FILE>
View (inline):cat <FILE>
Copy:cat <FILE> | pbcopy
Visual Studio Code:open <FILE> -a 'Visual Studio Code'
$EDITOR:$EDITOR <FILE>"
