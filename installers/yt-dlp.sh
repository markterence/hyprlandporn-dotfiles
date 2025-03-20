#!/bin/bash

# Function to print messages
print_message() {
    echo -e "\e[1;32m$1\e[0m"
}

# Function to print error messages
print_error() {
    echo -e "\e[1;31m$1\e[0m"
    exit 1
}

# Download the latest yt-dlp binary
print_message "Downloading the latest yt-dlp binary..."
curl -L -o yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux || print_error "Failed to download yt-dlp binary."

# Make the binary executable
print_message "Making the binary executable..."
chmod +x yt-dlp || print_error "Failed to make yt-dlp executable."

# Create the /opt/yt-dlp directory if it doesn't exist
print_message "Creating /opt/yt-dlp directory..."
sudo mkdir -p /opt/yt-dlp || print_error "Failed to create /opt/yt-dlp directory."

# Move the binary to /opt/yt-dlp
print_message "Moving the binary to /opt/yt-dlp..."
sudo mv yt-dlp /opt/yt-dlp/ || print_error "Failed to move yt-dlp binary to /opt/yt-dlp."

# Create a symbolic link in /usr/bin
print_message "Creating a symbolic link in /usr/bin..."
sudo ln -sf /opt/yt-dlp/yt-dlp /usr/bin/yt-dlp || print_error "Failed to create symlink in /usr/bin."

# Verify installation
print_message "Verifying installation..."
if yt-dlp --version > /dev/null 2>&1; then
    print_message "yt-dlp installed successfully."
else
    print_error "yt-dlp installation failed."
fi

# Verify PATH update
print_message "Verifying PATH update..."
echo $PATH