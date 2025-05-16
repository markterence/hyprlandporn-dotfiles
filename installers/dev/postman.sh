#!/bin/bash -e

function _install {
    cd /tmp || exit
    echo "Downloading Postman ..."

    wget https://dl.pstmn.io/download/latest/linux_64 -O postman.tar.gz
    tar -xzf postman.tar.gz

    echo "Installing to opt..."
    if [ -d "/opt/postman" ];then
        sudo rm -rf /opt/postman
    fi
    sudo mv Postman /opt/postman

    echo "Creating symbolic link..."
    if [ -L "/usr/bin/postman" ];then
        sudo rm -f /usr/bin/postman
    fi
    sudo ln -s /opt/postman/Postman /usr/bin/postman
    echo "Postman installed."
}

function _desktop_entry {
    content="[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/usr/bin/postman --ozone-platform=wayland --enable-features=UseOzonePlatform,WaylandWindowDecorations,WaylandLinuxDrmSyncobj
Icon=/opt/postman/icons/icon_128x128.png
Terminal=false
Type=Application
Categories=Development;"

    echo "Creating desktop entry..."
    if [ -f "/usr/share/applications/postman.desktop" ];then
        sudo rm -f /usr/share/applications/postman.desktop
    fi
    echo "Installing desktop entry..."
    # Write the content to the file
    sudo bash -c "printf '%s\n' \"$content\" > /usr/share/applications/postman.desktop"
    
    echo "Desktop entry created."
}

function _clean_up {
    cd /tmp || exit
    echo "Cleaning up..."
    rm postman.tar.gz

}

function _main {
    _install
    _desktop_entry
    _clean_up
    echo "Done!"
}
_main