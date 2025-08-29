#!/bin/bash -e
#
# DBeaver-CE Installer Script
# ------------------------
# Link: https://dbeaver.io/
# Description: 
#   Installs DBeaver CE from tar.gz into /opt/dbeaver-ce and creates a desktop entry.
#   Also setups symlink to /usr/local/bin/dbeaver and /usr/localbin/dbeaver-ce.
# Repo: https://github.com/markterence/hyprlandporn-dotfiles/installers/dev/dbeaver-ce.sh

# Install DBeaver Community Edition
curl -L https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz -o /tmp/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz

# Remove old installation if exists
[ -d /opt/dbeaver-ce ] && sudo rm -rf /opt/dbeaver-ce

# Create installation directory
sudo mkdir -p /opt/dbeaver-ce

# Extract the tar.gz to /opt/dbeaver-ce
sudo tar -xzf /tmp/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz -C /opt/dbeaver-ce --strip-components=1

# Create symlinks
sudo ln -sf /opt/dbeaver-ce/dbeaver-ce /usr/local/bin/dbeaver
sudo ln -sf /opt/dbeaver-ce/dbeaver-ce /usr/local/bin/dbeaver-ce

# copy desktop entry
sudo cp /opt/dbeaver-ce/dbeaver-ce.desktop /usr/share/applications/

# Fix paths and icons
sudo sed -i 's|/usr/share/dbeaver-ce/|/opt/dbeaver-ce/|g' /usr/share/applications/dbeaver-ce.desktop

# Clean-up
rm -f /tmp/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz

# Notes:
echo ""
echo "------"
echo "DBeaver Community Edition installed."
echo "On Wayland, you might need to run it with 'env GDK_BACKEND=x11 dbeaver' for proper functionality."
echo "Copy the desktop entry to your local applications folder if you want to customize it:"
echo "cp /usr/share/applications/dbeaver-ce.desktop ~/.local/share/applications/"