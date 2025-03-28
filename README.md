# Hyprlandporn dotfiles

This is daily driver desktop configuration files for my Arch Linux system. I currently use EndeavourOS, which is based on Arch Linux. The desktop environment was KDE Plasma and installed Hyprland along with it.

I used a pre-configured setup from [ml4w (Stephan Raabe)](https://github.com/mylinuxforwork/) and mostly from [JaKooLit](https://github.com/JaKooLit/) :D

## Table of Contents

- [Scripts](#scripts)
  - [Available Scripts](#available-scripts)
- [Hyprland config](#hyprland-config)

-----------------
<img src="https://markterence.github.io/images/hyprland/swappy-20250228-234939.png?w=cache_busting" width="480"/>
<img src="https://markterence.github.io/images/hyprland/swappy-20250321-122003.png?v=cache_bust" width="480"/>
<img src="https://markterence.github.io/images/hyprland/swappy-20250321-122027.png?cache_buster=1" width="480"/>

------------------

## Scripts

My scripts are located in `bin` folder of this repository. This can be added to the `PATH` environment variable to be able to run the scripts from anywhere.

### Available Scripts

#### `imgur-upload`

Dead simple script to upload images to imgur. Requires manual authorization to an ACCESS TOKEN to be able to upload images on non-public albums.

```sh
imgur-upload /path/to/image.png
```

#### `mah-beans`

Sometimes I don't know what scripts I have in my `bin` folder. This script lists all the scripts in the `bin` folder.

```sh
mah-beans
```

#### `random-bytes`

Because `head -c $count /dev/urandom` is too long to type and I don't want to remember it.

```sh
random-bytes 16 | base64
```

#### `yt`

Download youtube videos straight from the terminal to my drive using `yt-dlp`. Downloaded videos are saved in `~/Videos` folder.

It picks `bestvideo[height<=?1080]+bestaudio/best` format and saves with `.mkv` extension.

```sh
yt https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

---------

## Hyprland config 

I had modified the configuration files to suit my needs. 

### Modifications

#### Keybinds

| My Keybind | Original Keybind | Description |
| --- | --- | --- |
| `SUPER` + `SHIFT` + `END` | `SUPER` + `SHIFT` + `Q` | Kill active window |
| `SUPER` + `END` | `SUPER` + `Q` | Quit active window, not kill (depends on app/window) |

#### Window Rules

- Force GeForce NOW to windowed mode, this prevents GeForce NOW to takeover and go fullscreen when launching a game.

#### Decorations

- Playing around with the decorations. Used `border-plus-plus` hyprland plugin.

#### Startup Apps

- Added `exec-once = sleep 1 && hyprpm reload` to reload the hyprland plugin.
