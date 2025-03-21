#!/bin/sh
# filepath: install.sh

# Define the repo bin directory
SCRIPT_DIR="$HOME/hyprlandporn-dotfiles/bin"
ZSH_CONFIG="$HOME/.zshrc"

echo "Adding $SCRIPT_DIR to your PATH in zsh configuration..."

# Check if the directory is already in PATH
if grep -q "PATH=.*$SCRIPT_DIR" "$ZSH_CONFIG"; then
    echo "The directory is already in your PATH."
else
    # Add the directory to PATH in .zshrc
    echo "" >> "$ZSH_CONFIG"
    echo "# Adding hyprlandporn-dotfiles bin directory to PATH" >> "$ZSH_CONFIG"
    echo "export PATH=\"\$PATH:$SCRIPT_DIR\"" >> "$ZSH_CONFIG"
    
    echo "Added $SCRIPT_DIR to your PATH in $ZSH_CONFIG."
    echo "To apply changes immediately, run: source $ZSH_CONFIG"
fi

# Make sure the script is executable
chmod +x "$SCRIPT_DIR/yt"

echo ""
echo "Installation complete!"
echo "You can now use the 'yt' command from anywhere."
echo "Usage: yt [URL]"
echo "Videos will be saved to ~/Videos"