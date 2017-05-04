module.exports = [
    {
        id: 'development',
        type: 'hotkeys',
            config: {
            title: 'Development',
            hotkeys: f => Promise.resolve([
                { key: 'S', name: 'Open in SourceTree', onSelected: f => {
                    f.hammerspoon.getFrontmostWindowTitle().then(title => {
                        const matches = title.match(/.*\[(.*)\].*/);

                        if (! matches || matches.length < 2) {
                            return f.error(`Can't open SourceTree from window [${title}]`);
                        }

                        const path = matches[1];
                        return f.terminal.run(`open ${path} -a "SourceTree"`).then(f.finish()).catch(error => f.error('Couldn\'t start SourceTree, are you sure it\'s installed?'));
                    }).catch(error => f.error('Couldn\'t run `hs` cli. Are you sure Hammerspoon is running?'));
                }},
                { key: 'R', name: 'Go to Repository', onSelected: f => {
                    f.hammerspoon.getFrontmostWindowTitle().then(title => {
                        const matches = title.match(/.*\[(.*)\].*/);

                        if (! matches || matches.length < 2) {
                            return f.error(`Can't find repository for window "${title}"`);
                        }

                        if (matches.length === 2) {
                            const path = matches[1];

                            f.terminal.run(`cd ${path} && git remote get-url origin`).then(gitUrl => {
                                const matches = gitUrl.match(/git@(.*):(.*)\.git/);

                                if (! matches || matches.length < 3) {
                                    return f.error(`Can't get remote for [${path}] of window [${title}]`);
                                }

                                const host = matches[1];
                                const repository = matches[2];

                                f.browser.open(`https://${host}/${repository}`).then(f.finish());
                            });
                        }
                    }).catch(error => f.error('Couldn\'t run `hs` cli. Are you sure Hammerspoon is running?'));
                }}
            ])
        }
    }
]
