if application "Radium" is running then
  tell application "Radium"
    set theName to track name
    set theStation to station name
    set isPlaying to playing
    try
      if isPlaying then
        return "♫  " & theName & "#[fg=colour241] on #[fg=colour14]" & theStation & " "
      end if
    on error err
    end try
  end tell
end if
