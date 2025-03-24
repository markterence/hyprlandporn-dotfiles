#!/bin/bash -e

# https://flatpak.org/setup/EndeavourOS
# https://flatpak.org/setup/Arch

sudo pacman -S flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo