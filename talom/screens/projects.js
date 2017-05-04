const phpstorm = 'PhpStorm 2017.1 EAP';
const vscode = 'Visual Studio Code';

module.exports = [
    {
        id: 'projects',
        type: 'select',
        config: {
            placeholder: 'Projects',
            options: f => [
                { label: 'Talom', sublabel: '/Users/bryantebeek/Projects/Talom', application: vscode },
                { label: 'Lifely Cli', sublabel: '/Users/bryantebeek/.lifely-cli', application: vscode },
                { label: 'Fresh Heroes', sublabel: '/Users/bryantebeek/Lifely/Freshheroes', application: phpstorm },
                { label: 'BNP - (Mijn BP, Belasting adviseurs)', sublabel: '/Users/bryantebeek/Lifely/Projects/bnp', application: phpstorm },
                { label: 'Simon', sublabel: '/Users/bryantebeek/Lifely/Office/Simon', application: vscode },
                { label: 'Startdashboard', sublabel: '/Users/bryantebeek/Lifely/Projects/startdashboard', application: vscode }
            ],
            onSelected: (f, project) => {
                f.applications.start(project.application, project.sublabel)
                    .then(() => f.finish());
            }
        }
    }
]
