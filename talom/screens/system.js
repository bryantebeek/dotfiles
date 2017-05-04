const ip = require('ip');

module.exports = [
    {
        id: 'system',
        type: 'select',
        config: {
            placeholder: 'Filter',
            options: f => Promise.resolve([
                {label: 'IP', sublabel: ip.address()}
            ]),
            onSelected: (f, item) => {
                f.clipboard.copy(item.sublabel)
                    .then(() => f.finish());
            }
        }
    }
]
