const Promise = require('bluebird');
const Trello = require('trello');
const trello = new Trello(process.env.TRELLO_API_KEY, process.env.TRELLO_USER_TOKEN);
const boards = trello.getBoards('512f0d23d021c74d15000a92');

const apisauce = require('apisauce');
const api = apisauce.create({
    baseURL: 'https://api.buddy.works/',
    headers: {
        'Authorization': 'Bearer 3af3947d-99f1-4b76-b17d-efc9e168de3c',
        'Content-Type': 'application/json'
    }
});

const pipelines = [];

api.get('/workspaces/lifely/projects').then(result => {
    const projects = result.data.projects;

    projects.forEach(project => {
        api.get(`/workspaces/lifely/projects/${project.name}/pipelines`).then(result => {
            result.data.pipelines.forEach(pipeline => {
                pipelines.push({
                    label: project.display_name,
                    sublabel: pipeline.name,
                    url: pipeline.html_url
                });
            });
        });
    });
});

module.exports = [
    {
        id: 'search',
        type: 'hotkeys',
        config: {
            title: 'Search',
            hotkeys: f => [
                { key: 'S', name: 'Directories', onSelected: f => f.goto('search-directories') },
                { key: 'A', name: 'Applications', onSelected: f => f.goto('search-applications') },
                { key: 'O', name: 'Online', onSelected: f => f.goto('search-online') },
                { key: 'T', name: 'Trello', onSelected: f => f.goto('search-trello') },
                { key: 'D', name: 'Devdocs', onSelected: f => f.goto('search-docs') },
                { key: 'B', name: 'Buddy', onSelected: f => f.goto('search-buddy') },
            ]
        }
    },
    {
        id: 'search-bookmarks',
        type: 'select',
        config: {
            placeholder: 'Bookmarks',
            options: f => [
                { label: 'Digitalocean', sublabel: 'https://cloud.digitalocean.com/droplets' },
                { label: 'Transip', sublabel: 'https://www.transip.nl/cp/domein-hosting' },
                { label: 'AWS - S3', sublabel: 'https://console.aws.amazon.com/s3/home?region=eu-west-1' },
                { label: 'AWS - IAM', sublabel: 'https://console.aws.amazon.com/iam/home?region=eu-west-1#/home' },
                { label: 'Bitbucket - Lifely', sublabel: 'https://bitbucket.org/lifelynl/profile/repositories' },
                { label: 'Buddy Works', sublabel: 'https://app.buddy.works/lifely' }
            ],
            onSelected: (f, bookmark) => {
                f.browser.open(bookmark.sublabel)
                    .then(() => f.finish());
            }
        }
    },
    {
        id: 'search-buddy',
        type: 'select',
        config: {
            placeholder: 'Search a Buddy pipeline',
            options: (f, filter) => new Promise((resolve, reject) => {
                resolve(
                    pipelines.filter(pipeline => ! filter || pipeline.label.toLowerCase().indexOf(filter.toLowerCase()) > -1)
                );
            }),
            onSelected: (f, pipeline) => {
                f.browser.open(pipeline.url)
                    .then(() => f.finish());
            }
        }
    },
    {
        id: 'search-trello',
        type: 'select',
        config: {
            placeholder: 'Search a Trello board',
            options: (f, filter) => new Promise((resolve, reject) => {
                boards.then(results => {
                    resolve(
                        results
                            .filter(board => ! filter || board.name.toLowerCase().indexOf(filter.toLowerCase()) > -1)
                            .filter(board => ! board.closed)
                            .map(board => {
                                console.log(board);

                                return {
                                    label: board.name,
                                    sublabel: board.url
                                };
                            })
                    );
                });
            }),
            onSelected: (f, board) => {
                f.browser.open(board.sublabel)
                    .then(() => f.finish());
            }
        }
    },
    {
        id: 'search-docs',
        type: 'input',
        config: {
            placeholder: 'Search Devdocs',
            onSelected: (f, query) => {
                f.browser.open(`http://devdocs.io/#q=${query}`)
                    .then(() => f.finish());
            }
        }
    },
    {
        id: 'search-online',
        type: 'select',
        config: {
            placeholder: 'Search',
            options: f => Promise.resolve([
                { label: 'Google', sublabel: 'https://google.com#q={query}' },
                { label: 'Npm', sublabel: 'https://www.npmjs.com/search?q={query}' },
                { label: 'Bitbucket', sublabel: 'https://bitbucket.org/dashboard/repositories?search={query}' },
                { label: 'Packagist', sublabel: 'https://packagist.org/search/?q={query}' }
            ]),
            onSelected: (f, engine) => {
                f.save('engine', engine)
                    .then(f.goto('search-online-query'));
            }
        }
    },
    {
        id: 'search-online-query',
        type: 'input',
        config: {
            placeholder: f => f.get('engine').then(engine => `Search ${engine.label}`),
            onSelected: (f, query) => {
                f.get('engine')
                    .then(engine => f.browser.open(engine.sublabel.replace('{query}', query)))
                    .then(() => f.finish());
            }
        }
    },
    {
        id: 'search-directories',
        type: 'select',
        config: {
            live: true,
            placeholder: 'Search a directory',
            options: (f, filter) => f.finder.search(filter, f.finder.TYPE_DIRECTORY),
            onSelected: (f, directory) => {
                f.save('file', directory)
                    .then(f.goto('file-actions'));
            }
        }
    },
    {
        id: 'search-files',
        type: 'select',
        config: {
            live: true,
            placeholder: 'Search a file',
            options: (f, filter) => f.finder.search(filter, f.finder.TYPE_FILE),
            onSelected: (f, file) => {
                f.save('file', file)
                    .then(f.goto('file-actions'));
            }
        }
    },
    {
        id: 'search-applications',
        type: 'select',
        config: {
            live: true,
            placeholder: 'Search an application',
            options: (f, filter) => f.finder.search(filter, f.finder.TYPE_APPLICATION),
            onSelected: (f, application) => {
                f.applications.start(application.path)
                    .then(f.finish());
            }
        }
    }
]
