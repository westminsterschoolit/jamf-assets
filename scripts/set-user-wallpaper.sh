#!/bin/bash

###
#
# Name: Set All User Wallpapers.sh
# Description: Downloads a custom wallpaper and sets it for all local user accounts.
# This script is designed for a managed environment and should be run as root.
#
###

# --- Configuration ---
# The URL of the wallpaper image to be downloaded.
WALLPAPER_URL="https://raw.githubusercontent.com/westminsterschoolit/jamf-assets/main/mac-wallpapers/westminster-wallpaper.jpg"

# The destination path for the downloaded image. This location is accessible by all users.
DESTINATION_PATH="/Library/Desktop Pictures/WMS-wallpaper.jpg"

# --- Main Script ---

# 1. Download the wallpaper image.
# Use curl with -fsS for a quiet, fail-fast download.
echo "📥 Downloading wallpaper from $WALLPAPER_URL..."
/usr/bin/curl -fsS -o "$DESTINATION_PATH" "$WALLPAPER_URL"

# Check if the download was successful.
if [ $? -ne 0 ]; then
  echo "❌ Error: Failed to download the wallpaper file. Exiting."
  exit 1
fi

# 2. Set the downloaded wallpaper for all user accounts.
# A more reliable way to get a list of active users is to iterate through
# the home directories in /Users, which ensures we only target real accounts.
echo "🔄 Setting wallpaper for all user accounts..."
for USER_HOME in /Users/*; do
    # Get the username from the home directory path.
    USER=$(basename "$USER_HOME")
    
    # Skip any system or special users (e.g., Shared, _).
    if [[ "$USER" == "Shared" || "$USER" == "_"* ]]; then
        continue
    fi

    echo "    👤 Setting wallpaper for user: $USER"

    # Set the wallpaper using a more robust defaults command.
    # The 'defaults' command uses the correct property list structure and file.
    # We use 'sudo -u "$USER"' to run the command with the user's permissions.
    /usr/bin/sudo -u "$USER" /usr/bin/defaults write "$USER_HOME"/Library/Preferences/com.apple.desktop.plist Background '{
        Change = "Time";
        ChangePath = "'"$DESTINATION_PATH"'";
        DrawStyle = "FillScreen";
        ImageFilePath = "'"$DESTINATION_PATH"'";
        ImageFileAlias = { };
    }'
    
    # Reload the Dock to apply the change immediately. This is the correct
    # way to force the desktop picture to refresh for the user.
    # We use 'pgrep' and 'launchctl' to target the correct user's Dock process.
    USER_UID=$(/usr/bin/id -u "$USER")
    DOCK_PID=$(/usr/bin/pgrep -u "$USER_UID" "Dock")
    if [ -n "$DOCK_PID" ]; then
        /usr/bin/kill "$DOCK_PID"
        echo "    ✅ Refreshed Dock for user: $USER"
    fi
done

echo "✅ Wallpaper script completed successfully."
exit 0
