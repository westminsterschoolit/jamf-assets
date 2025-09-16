#!/bin/sh

###
#
# Name: Install Xcode Command Line Tools.sh
# Description: Installs Xcode Command Line Tools if they are not already present.
#
# Based on original script by Palantir Technologies, Inc.
#
###

# Check for Xcode Command Line Tools installation
# The xcode-select command returns a non-zero exit code if the tools aren't installed.
if /usr/bin/xcode-select --print-path &>/dev/null; then
  echo "✅ Xcode Command Line Tools are already installed."
  exit 0
fi

echo "Installing Xcode Command Line Tools..."

# Request the installation of the tools. This command automatically handles the download and installation.
# The `sudo` command is used here to ensure the command has the necessary permissions.
sudo xcode-select --install

# Wait for the user to complete the installation from the GUI dialog.
# The script will pause until the user accepts the prompt, or it times out.
# This approach is generally more reliable than trying to manage the installation
# with `softwareupdate` directly, which has become less consistent over time.
# The `xcode-select --install` command will pop up a GUI dialog box.
while /bin/true; do
  if /usr/bin/xcode-select --print-path &>/dev/null; then
    echo "✅ Xcode Command Line Tools installation complete."
    exit 0
  fi
  
  # Check if the process is still running; if not, assume the user canceled it.
  # This part is optional but adds better user experience.
  if ! pgrep -f "Install Command Line Developer Tools.app" >/dev/null; then
    echo "❌ Xcode Command Line Tools installation was canceled by the user."
    exit 1
  fi
  
  /bin/sleep 5
done
