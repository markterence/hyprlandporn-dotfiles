#!/bin/bash -e

# Install Cloudflared binary

function installCloudflared() {
    # Download Cloudflared binary and install it on /opt/cloudflared-bin directory
    echo "Downloading Cloudflared binary..."
    url="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64"
    # download on /tmp directory
    curl -L -o /tmp/cloudflared $url
    # make it executable
    chmod +x /tmp/cloudflared
    # move to /opt/cloudflared-bin
    sudo mkdir -p /opt/cloudflared-bin
    sudo mv /tmp/cloudflared /opt/cloudflared-bin/cloudflared
    # create a symlink
    sudo ln -sf /opt/cloudflared-bin/cloudflared /usr/bin/cloudflared
    echo "Cloudflared binary installed successfully."

    # print version
    cloudflared --version
}


# Get the flags: (-y for "yes") when using the script in a non-interactive mode
while getopts ":y" opt; do
  case ${opt} in
    y )
      YES="true"
      echo "Option -y is enabled. This will skip all prompts and use default values."
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done

# Check if Cloudflared binary exists and and prompt for overwrite
if [ -f /opt/cloudflared-bin/cloudflared ]; then
    if [ "$YES" != "true" ]; then
        read -p "Cloudflared binary already exists. Do you want to overwrite it? (y/n): " overwrite
    else
        overwrite="y"
    fi
    if [ "$overwrite" == "y" ]; then
        installCloudflared
    else
        echo "Skipping Cloudflared installation."
    fi
else
    installCloudflared
fi
