#!/bin/bash -e
# filepath: /home/lemon/hyprlandporn-dotfiles/installers/dev/docker-post-install.sh

# Check if Docker daemon config directory exists
if [ ! -d /etc/docker ]; then
    echo "Creating Docker configuration directory..."
    sudo mkdir -p /etc/docker
fi

# Initialize with default config if file doesn't exist
if [ ! -f /etc/docker/daemon.json ]; then
    echo "daemon.json doesn't exist, creating with default logging configuration"
    cat > /tmp/daemon.json.tmp << EOF
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "1"
  }
}
EOF
    echo "Created new configuration:"
    cat /tmp/daemon.json.tmp

else
    echo "Found daemon.json at /etc/docker/daemon.json"
    echo "Original content:"
    cat /etc/docker/daemon.json
    
    # Create a working copy
    cp /etc/docker/daemon.json /tmp/daemon.json.tmp
    echo "Created temporary copy at /tmp/daemon.json.tmp"
    
    # Add log-driver if not exists
    if ! jq -e '.["log-driver"]' /tmp/daemon.json.tmp > /dev/null; then
        echo "Adding log-driver configuration..."
        jq '. + {"log-driver": "json-file"}' /tmp/daemon.json.tmp > /tmp/daemon.json.new
        cat /tmp/daemon.json.new > /tmp/daemon.json.tmp
        echo "Content after adding log-driver:"
        cat /tmp/daemon.json.tmp
    else
        echo "log-driver already exists, skipping"
    fi

    # Add log-opts if not exists
    if ! jq -e '.["log-opts"]' /tmp/daemon.json.tmp > /dev/null; then
        echo "Adding log-opts configuration..."
        jq '. + {"log-opts": {"max-size": "10m", "max-file": "1"}}' /tmp/daemon.json.tmp > /tmp/daemon.json.new
        cat /tmp/daemon.json.new > /tmp/daemon.json.tmp
        echo "Content after adding log-opts:"
        cat /tmp/daemon.json.tmp
    else
        echo "log-opts already exists, skipping"
    fi
fi

# Verify file has content
if [ ! -s /tmp/daemon.json.tmp ]; then
    echo "Error: Temporary file is empty, something went wrong."
    exit 1
fi

# Validate docker daemon config
echo "Validating docker daemon config..."
dockerd --validate --config-file=/tmp/daemon.json.tmp

# Show the content of the daemon.json file
echo "Final docker configuration: [TEMPORARY FILE]"
cat /tmp/daemon.json.tmp

# If we've reached this point, the configuration is valid, so we can apply it
# sudo mv /tmp/daemon.json.tmp /etc/docker/daemon.json
echo "Docker configuration ready to be applied"

# Uncomment the following line to actually update the file
sudo mv /tmp/daemon.json.tmp /etc/docker/daemon.json
 
echo "Updated daemon.json:"
cat /etc/docker/daemon.json