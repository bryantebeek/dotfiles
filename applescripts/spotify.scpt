if application "Spotify" is running then
  tell application "Spotify"
    set theName to name of the current track
    set theArtist to artist of the current track
    set theState to player state
    try
      if theState equals playing then
        return "♫  " & theName & " - " & theArtist & " "
      end if
    on error err
    end try
  end tell
end if
