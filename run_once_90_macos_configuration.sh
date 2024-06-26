# {{ if (eq .chezmoi.os "darwin") -}}
#!/bin/bash

set -eufo pipefail

# ~/.macos — https://mths.be/macos

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#################################################
# Dock                                          #
#################################################

# Set the icon size of Dock items to 32 pixels
defaults write com.apple.dock tilesize -int 32

#################################################
# Safari & WebKit                               #
#################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

#################################################
# Keyboard                                      #
#################################################

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

#################################################
# Trackpad                                      #
#################################################
defaults write NSGlobalDomain com.apple.trackpad.forceClick -int 1
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

#################################################
# Terminal                                      #
#################################################

# General / New window with Pro profile:
defaults write com.apple.Terminal "Startup Window Settings" -string Pro

# Profile: default Pro profile:
defaults write com.apple.Terminal "Default Window Settings" -string Pro

#################################################
# iTerm2                                        #
#################################################

# 💡 echo nested values with "print"; use "set" to write values:
#    /usr/libexec/PlistBuddy -c "print 'New Bookmarks':0:'Scrollback Lines'" ~/Library/Preferences/com.googlecode.iterm2.plist
#    /usr/libexec/PlistBuddy -c "write 'New Bookmarks':0:'Scrollback Lines'" 10000 ~/Library/Preferences/com.googlecode.iterm2.plist

# Appearance/Dimming: Dim background windows
defaults write com.googlecode.iterm2 DimBackgroundWindows -bool true

# Appearance/Dimming: Dimming amount
defaults write com.googlecode.iterm2 SplitPaneDimmingAmount -float 0.15

# Advanced: Scroll wheel sends arrow keys when in alternate screen mode. (ie. scrolling in bat)
defaults write com.googlecode.iterm2 AlternateMouseScroll -int 1

# Profiles/Window: Settings for New Windows
/usr/libexec/PlistBuddy -c "set 'New Bookmarks':0:'Rows' 26" ~/Library/Preferences/com.googlecode.iterm2.plist

# Profiles/Terminal: Scrollback Buffer (10000 lines)
/usr/libexec/PlistBuddy -c "set 'New Bookmarks':0:'Scrollback Lines' 10000" ~/Library/Preferences/com.googlecode.iterm2.plist

# Profiles/Text: Enable Blinking Cursor
/usr/libexec/PlistBuddy -c "set 'New Bookmarks':0:'Blinking Cursor' 1" ~/Library/Preferences/com.googlecode.iterm2.plist

# Profile/Colors: Snazzy Theme
defaults read com.googlecode.iterm2 | grep -q "Snazzy" ||
  (curl -Ls https://raw.githubusercontent.com/sindresorhus/iterm2-snazzy/main/Snazzy.itermcolors > /tmp/Snazzy.itermcolors && open /tmp/Snazzy.itermcolors)

# {{ end -}}

echo "Done. Note that some of these changes require a logout/restart to take effect."
