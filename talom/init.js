const fs = require('fs');
const path = require('path');

module.exports = function() {

	let screens = [
		'file-actions',

		'applications',
		'projects',
		'development',
		'search',
		'system',
	];

	let pages = screens.map(screen => require(`./screens/${screen}`)).reduce((allScreenPages, screenPages) => { return allScreenPages.concat(screenPages) }, [])

	pages = pages.concat([
		{
			id: 'home',
			type: 'hotkeys',
			config: {
				title: 'Home',
				hotkeys: f => Promise.resolve([
					{ key: 'A', name: 'Applications', onSelected: f => f.goto('applications') },
					{ key: 'B', name: 'Bookmarks', onSelected: f => f.goto('search-bookmarks') },
					{ key: 'D', name: 'Development', onSelected: f => f.goto('development') },
					{ key: 'P', name: 'Projects', onSelected: f => f.goto('projects') },
					{ key: 'S', name: 'Search', onSelected: f => f.goto('search') },
					{ key: '#', name: 'System', onSelected: f => f.goto('system') }
				])
			}
		}
	]);

	return {
		pages: pages
	};

}
