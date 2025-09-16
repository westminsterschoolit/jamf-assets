#!/bin/bash
# URL of the image you want to download
imageURL="https://raw.githubusercontent.com/westminsterschoolit/jamf-assets/refs/heads/main/mac-wallpapers/westminster-wallpaper.jpg"

# Destination path on the Mac
destinationPath="/Users/Shared/wallpaper.jpg"

# Download the image
curl -o "$destinationPath" "$imageURL"
# Check if the wallpaper file exists
if [ ! -f "$destinationPath" ]; then
    echo "Error: The specified wallpaper file does not exist at $WALLPAPER_PATH"
    exit 1
fi
# The path to the cache file that controls the login screen wallpaper
LOGIN_CACHE_FILE="/Library/Caches/com.apple.Desktop.admin.png"

# The path to the cache file for the login screen's background color
LOGIN_PLIST="/Library/Preferences/com.apple.loginwindow.plist"

# The path to the login screen's wallpaper configuration file
LOGIN_DESKTOP_PLIST="/Library/Preferences/com.apple.Desktop.plist"

# Use sips to resize the image to a common resolution (optional but recommended)
# This prevents display issues on different screen sizes.
# You can adjust the resolution as needed.
sips -s format png "$destinationPath" --out "/tmp/login_wallpaper.png"

# Set the wallpaper for the login screen by replacing the cache file
cp "/tmp/login_wallpaper.png" "$LOGIN_CACHE_FILE"

# Set permissions on the new cache file
chown root:wheel "$LOGIN_CACHE_FILE"
chmod 644 "$LOGIN_CACHE_FILE"

# Set the background for the login window to point to the new image
defaults write "$LOGIN_PLIST" "Desktop Picture" "$destinationPath"
defaults write "$LOGIN_PLIST" "lastUser" "loginwindow"
defaults write "$LOGIN_DESKTOP_PLIST" "Background" "$destinationPath"

echo "Successfully set the login screen wallpaper to $destinationPath"

exit 0
