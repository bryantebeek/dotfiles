if application "Radiant Player" is running then
  tell application "Radiant Player"
    set theName to current song name
    set theArtist to current song artist
    set theState to player state
    try
      if theState equals 2 then
        return "♫  " & theName & " - " & theArtist & " "
      end if
    on error err
    end try
  end tell
end if
