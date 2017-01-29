applications = {}

applications.show = function(name)
    return function(cb) 
        hs.application.launchOrFocus(name)
        cb()
    end 
end

applications.showAndKeyStroke = function(name, modifiers, key)
    return function(cb)
        hs.application.launchOrFocus(name)
        hs.timer.doAfter(0.5, function() 
            hs.eventtap.keyStroke(modifiers, key)
            cb()
        end)
    end
end

return applications