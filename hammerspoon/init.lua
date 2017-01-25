-----
-- Automatic configuration reloading
-----
hs.pathwatcher.new(os.getenv('HOME') .. '/.dotfiles/hammerspoon/', hs.reload):start()

-----
-- Load external modules
-----
local drillfork = require('drillfork/main')
drillfork.setConfigurationFile('config')
drillfork.start()

-----
-- Show a message when the configuration is reloaded
-----
hs.alert.show('Configuration reloaded')
