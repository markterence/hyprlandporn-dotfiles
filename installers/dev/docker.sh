#!/bin/bash -e

installDocker() {
    sudo pacman -S docker --noconfirm
    sudo systemctl enable docker.socket

    # install docker-compose
    # sudo pacman -S docker-compose --noconfirm

    # Add user to docker group
    sudo usermod -aG docker $USER

    # reload group
    newgrp docker

}

installDocker