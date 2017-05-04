module.exports = [
    {
        id: 'file-actions',
        type: 'select',
        config: {
            placeholder: f => f.get('file').then(file => 'Choose action for ' + file.name),
            options: f => [
                {label: 'Open with...', id: 'open-with'},
                {label: 'Open', id: 'open'},
                {label: 'Reveal in Finder', id: 'reveal'},
                {label: 'Copy path', id: 'copy-path'},
            ],
            onSelected: (f, action) => {
                f.get('file')
                    .then(file => {
                        switch (action.id) {
                            case 'open': f.terminal.run(`open '${file.path}'`).then(f.finish()); break;
                            case 'open-with': f.goto('file-actions-open-with'); break;
                            case 'reveal': f.finder.reveal(file.path).then(f.finish());
                            case 'copy-path': f.clipboard.copy(file.path).then(f.finish());
                            default: f.finish();
                        }
                    });
            }
        }
    },
    {
        id: 'file-actions-open-with',
        type: 'select',
        config: {
            live: true,
            placeholder: f => f.get('file').then(file => 'Search application to open ' + file.name),
            options: (f, filter) => f.finder.search(filter, f.finder.TYPE_APPLICATION),
            onSelected: (f, application) => {
                f.get('file')
                    .then(file => f.applications.start(application.path, file.path))
                    .then(f.finish());
            }
        }
    }
]
