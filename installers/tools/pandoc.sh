#!/bin/bash -e
#
# Pandoc Installer Script
# ------------------------
# Link: https://pandoc.org/
# Description:
#   Installs Pandoc from tar.gz into /opt/pandoc and symlinks the
#   binary to /usr/local/bin/pandoc.

dl_link=https://github.com/jgm/pandoc/releases/download/3.10.1/pandoc-3.10.1-linux-amd64.tar.gz

# Download the tarball
curl -L "$dl_link" -o /tmp/pandoc.tar.gz

# Remove old installation if exists
[ -d /opt/pandoc ] && sudo rm -rf /opt/pandoc

# Create installation directory
sudo mkdir -p /opt/pandoc

# Extract the tar.gz to /opt/pandoc
sudo tar -xzf /tmp/pandoc.tar.gz -C /opt/pandoc --strip-components=1

# Create symlink
sudo ln -sf /opt/pandoc/bin/pandoc /usr/local/bin/pandoc

# Clean-up
rm -f /tmp/pandoc.tar.gz

# Verify installation
pandoc --version
