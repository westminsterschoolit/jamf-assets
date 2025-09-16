#!/bin/sh

###
#
# Name: Set Mac Name to Serial Number.sh
# Description: Sets all three macOS hostnames to a standardized format using the Mac's serial number.
#
# This script is designed for use in a managed environment and should be run as root.
# It ensures consistent naming for local network services, Bonjour, and DNS.
#
###

# --- Configuration ---
# Prefix for the computer name. You can customize this.
# A common format includes a location or organization code.
NAME_PREFIX="WMS-MB"

# --- Main Script ---

# 1. Get the Mac's serial number.
# We'll use system_profiler for a more reliable way to get the hardware info.
echo "Retrieving the Mac's serial number..."
SERIAL_NUMBER=$(/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Serial Number (system)/ {print $4}')

# Check if the serial number was successfully retrieved.
if [ -z "$SERIAL_NUMBER" ]; then
  echo "❌ Error: Could not retrieve the Mac's serial number."
  exit 1
fi

# 2. Define the new computer name.
# The name should be alphanumeric and without spaces to prevent network issues.
NEW_NAME="${NAME_PREFIX}-${SERIAL_NUMBER}"
echo "Setting computer name to: $NEW_NAME"

# 3. Set all three hostnames for consistency.
# - ComputerName: The user-friendly name displayed in System Settings and Finder.
# - HostName: The name used for the TCP/IP network stack.
# - LocalHostName: The Bonjour (mDNS) name used for local network discovery.
# Using 'scutil' is the standard method for this task.
/usr/sbin/scutil --set ComputerName "$NEW_NAME"
/usr/sbin/scutil --set HostName "$NEW_NAME"
/usr/sbin/scutil --set LocalHostName "$NEW_NAME"

echo "✅ All hostnames have been successfully updated."
exit 0
