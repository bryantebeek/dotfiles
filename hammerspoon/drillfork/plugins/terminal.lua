terminal = {}

terminal.run = function(executable, arguments)
    return function(cb) 
        hs.task.new(executable, function(exitCode, stdout, stderr)
            hs.logger.new('Debug', 'Debug'):d(exitCode)
            hs.logger.new('Debug', 'Debug'):d(stdout)
            hs.logger.new('Debug', 'Debug'):d(stderr)
            cb()
        end, arguments):start()
    end 
end

return terminal