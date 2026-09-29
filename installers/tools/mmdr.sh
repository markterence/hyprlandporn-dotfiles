#!/bin/bash -e
#
# mmdr Mermaid renderer (mmdc)
# Link: https://github.com/1jehuang/mermaid-rs-renderer
# 

dl_link=https://github.com/1jehuang/mermaid-rs-renderer/releases/download/v0.3.1/mmdr-x86_64-unknown-linux-gnu.tar.gz

# Download the tarball
curl -L "$dl_link" -o /tmp/mmdr-x86_64-unknown-linux-gnu.tar.gz

# Remove old installation if exists
[ -d /opt/mmdr ] && sudo rm -rf /opt/mmdr

# Create installation directory
sudo mkdir -p /opt/mmdr

# Extract the tar.gz to /opt/mmdr
sudo tar -xzf /tmp/mmdr-x86_64-unknown-linux-gnu.tar.gz -C /opt/mmdr --strip-components=1

# Create symlink
sudo ln -sf /opt/mmdr/mmdr /usr/local/bin/mmdr

# Clean-up
rm -f /tmp/mmdr-x86_64-unknown-linux-gnu.tar.gz

# Verify installation
mmdr --version
