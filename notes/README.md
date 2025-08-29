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


## Cant mount drives

Start `hyprpolkitagent`.

```sh
systemctl --user start hyprpolkitagent
```

## Steam Games on NFTS drive

\*Reference: https://github.com/ValveSoftware/Proton/wiki/Using-a-NTFS-disk-with-Linux-and-Windows

----

Create mount point, get the UserID, GroupID and partition.

```sh
sudo mkdir -p /media/steamgames
id -u
id -g
sudo fdisk -l
```


```
$ mkdir -p ~/.steam/steam/steamapps/compatdata

$ ln -s ~/.steam/steam/steamapps/compatdata /path/to/drive/Games/Steam/steamapps/
```


## Mic

```
pactl load-module module-null-sink media.class=Audio/Sink sink_name=Virtual-Mic channel_map=front-left,front-right
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=Virtual-Mic channel_map=front-left,front-right
pw-link Virtual-Mic:monitor_FL Virtual-Mic:input_FL
pw-link Virtual-Mic:monitor_FR Virtual-Mic:input_FR
```