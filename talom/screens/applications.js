module.exports = [
    {
        id: 'applications',
        type: 'hotkeys',
            config: {
            title: 'Applications',
            hotkeys: f => Promise.resolve([
                { key: 'A', name: 'Applications (Search)', onSelected: f => f.goto('search-applications') },
                { key: 'C', name: 'Chrome', onSelected: f => f.applications.start('Google Chrome').then(() => f.finish()) },
                { key: 'V', name: 'Visual Studio Code', onSelected: f => f.applications.start('Visual Studio Code').then(() => f.finish()) },
                { key: 'S', name: 'Spotify', onSelected: f => f.applications.start('Spotify').then(() => f.finish()) },
                { key: 'M', name: 'Marxico', onSelected: f => f.applications.start('Default kidnkfckhbdkfgbicccmdggmpgogehop').then(() => f.finish()) },
                { key: 'Y', name: 'Vysor', onSelected: f => f.applications.start('Default gidgenkbbabolejbgbpnhbimgjbffefm').then(() => f.finish()) },
                { key: 'W', name: 'Wunderlist', onSelected: f => f.applications.start('Wunderlist').then(() => f.finish()) },
                { key: 'T', name: 'Trello', onSelected: f => f.applications.start('Trello').then(() => f.finish()) },
                { key: 'O', name: 'SourceTree', onSelected: f => f.applications.start('SourceTree').then(() => f.finish()) },
                { key: 'I', name: 'Airmail', onSelected: f => f.applications.start('Airmail 3').then(() => f.finish()) }
            ])
        }
    }
]
