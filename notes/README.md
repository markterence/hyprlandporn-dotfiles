# Notes


## Vivaldi flickering issue and keystore on KDE Plasma

Create/modify a desktop entry for Vivaldi with the following command:

```
--password-store="kwallet6" --ozone-platform=wayland --enable-features=UseOzonePlatform --use-cmd-decoder=validating  --use-gl=desktop
```

## Desktop entry files resetting after performing an update

Copy the desktop entry files from `/usr/share/applications` to `~/.local/share/applications` and modify them as needed.

```sh
# Example for Vivaldi
entry="vivaldi-stable.desktop"
cp /usr/share/applications/$entry ~/.local/share/applications/$entry
```
