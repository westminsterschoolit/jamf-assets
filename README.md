# 🏫 Westminster School JAMF Scripts & Assets
This repository holds scripts and image assets for the Westminster School IT team's use of JAMF, our mobile device management (MDM) solution. The primary goal is to centralize and version-control our custom solutions, ensuring consistency and ease of deployment across all school devices.

This README provides an overview of the repository's structure and a guide for how to use and contribute to it.

## 📂 Repository Structure

The repository is organized into two main directories:

**scripts/**: Contains various shell and Python scripts used for automation, device configuration, and maintenance tasks within JAMF policies. Scripts are organized into subdirectories based on their function.

**assets/**: Houses image files, icons, and other non-script assets. These are often used for custom branding in the Self Service app or for display during installation processes.

## 📜 Using the Scripts

Scripts in this repository are designed to be uploaded directly to JAMF Pro as scripts and then referenced in policies.

To use a script:

Navigate to the relevant subdirectory in scripts/.

Copy the raw script content.

In JAMF Pro, go to Settings > Computer Management > Scripts.

Click New and paste the script. Ensure the Name and Description are clear and follow our internal naming conventions.

Save the script. You can now use it in a new or existing policy.

## 🎨 Using the Assets

Assets are typically used to customize the user experience, such as adding department-specific logos to Self Service.

To use an asset:

Navigate to the assets/ directory and find the desired image.

In JAMF Pro, you can either link to the image directly if it's hosted on a web server or upload it to the appropriate section, such as Self Service > Branding for icons and banners.
Some of these are used directly in scripts for setting wallpapers. 

## ✍️ Contribution Guide

We welcome contributions from the IT team to improve our JAMF workflows. Follow these steps to contribute a new script or asset:

- Fork the repository to your personal GitHub account.
- Create a new, descriptive branch for your changes (e.g., add-chrome-update-script or add-it-support-icon).
- Add your new script or asset to the correct directory.
- Commit your changes with a clear, concise commit message.
- Push your branch to your forked repository.
- Create a Pull Request (PR) to the main repository's main branch. Provide a brief description of what your changes do and why they are necessary.

A senior member of the IT team will review your PR and merge it once it's approved.

## 🤝 Need Help?
If you have questions about the repository or need assistance with a script, please contact the IT team directly via our internal ticketing system or our Teams channel.
