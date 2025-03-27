# 8BitDo Ultimate 2C Wireless Controller on GeForce NOW Linux

I got an 8BitDo Ultimate 2C Wireless Controller and it works out of the box with Steam and other games that I run on Linux and it also gets detected in Gamepad testers in the browser where GeForce NOW is supposed to run (Chrome, Microsoft Edge). However, it doesn't work with GeForce NOW.

To make it work, I had to use `xboxdrv` to micic an Xbox controller and remap the buttons. You'll see when you tested it on `evtest`. Some buttons are using different names/codes. For example, the `A` button is `BTN_SOUTH` and the `B` button is `BTN_EAST`.

Save the config somewhere in your home directory, e.g. `~/config/xboxdrv/8bitdo-ultimate-2c-wireless/8bitdo-ultimate-2c-wireless.ini`

Run this script on another terminal. This will make the 8BitDo Ultimate 2C Wireless Controller work with GeForce Now.

```sh
#!/bin/sh -e

# Make 8BitDo Ultimate 2C Wireless Controller work with GeForce Now
# 2dc8:301c
# 2dc8:310a

# Get event from `evtest` command and look for the event that has the name of the controller
EVENT_ID=/dev/input/event25

CONFIG_FILE="/home/lemon/hyprlandporn-dotfiles/config/xboxdrv/8bitdo-ultimate-2c-wireless/8bitdo-ultimate-2c-wireless.ini"

# vendor_id:product_id from `lsusb` command
# Sometimes the 8BitDo Ultimate 2C Wireless controller is on "2dc8:301c"
# I dunno if this is the input mode switching from XInput to DInput
DEVICE_ID="2dc8:310a"

# I tried to get the device from --evdev, it works but will not respond after a while.
# xboxdrv --mimic-xpad --silent --quiet --evdev $EVENT_ID -c $CONFIG_FILE

# xinput? 
sudo xboxdrv --mimic-xpad --silent \
--quiet \
-c $CONFIG_FILE \
--type xbox360 \
--device-by-id $DEVICE_ID \
--detach-kernel-driver

# Example snippet from `man xboxdrv` to start a game.
# Start xboxdrv and launch a game, when game is closed so do xboxdrv.
#  #!/bin/sh
#    exec xboxdrv \
#      --trigger-as-button -s \
#      -- \
#      your_favorite_game
#    # EOF #
```

## Resources

- https://github.com/xboxdrv/xboxdrv
- https://github.com/medusalix/xone/
- https://github.com/atar-axis/xpadneo

When controller didn't work out of the box (Which it should), I found the following resources helpful:
- https://gist.github.com/ammuench/0dcf14faf4e3b000020992612a2711e2

-----

```sh
$ evtest

/dev/input/event25:	8BitDo 8BitDo Ultimate 2C Wireless Controller
/dev/input/event26:	8BitDo 8BitDo Ultimate 2C Wireless Controller Keyboard
/dev/input/event27:	8BitDo 8BitDo Ultimate 2C Wireless Controller Mouse
```

```sh
$ lsusb

Bus 001 Device 046: ID 2dc8:310a 8BitDo 8BitDo Ultimate 2C Wireless Controller
```

## 8BitDo Ultimate 2C Wireless Controller xboxdrv config mapping

```ini
# xboxdrv config file
[xboxdrv]
ui-clear = true
#evdev-grab = false
dpad-as-button = true
extra-devices = false
mimic-xpad = true
device-name = "8BitDo 8BitDo Ultimate 2C Wireless Controller"

[evdev-keymap]
BTN_SOUTH = A
BTN_EAST = B
BTN_NORTH = X
BTN_WEST = Y

BTN_START = START
BTN_SELECT = SELECT
BTN_MODE = GUIDE

BTN_TR = RB
BTN_TL = LB
BTN_THUMBL = TL
BTN_THUMBR = TR

[evdev-absmap]
ABS_HAT0X = DPAD_X
ABS_HAT0Y = DPAD_Y

ABS_X = X1
ABS_Y = Y1
ABS_BRAKE = LT
ABS_GAS = RT
ABS_Z = X2
ABS_RZ = Y2

[axismap]
Y1 = Y1
Y2 = Y2

[ui-axismap]
X1 = ABS_X
Y1 = ABS_Y
X2 = ABS_RX
Y2 = ABS_RY
LT = ABS_Z
RT = ABS_RZ

DPAD_X = ABS_HAT0X
DPAD_Y = ABS_HAT0Y

[ui-buttonmap]
start  = BTN_START
guide  = BTN_MODE
back   = BTN_SELECT

X = BTN_X
Y = BTN_Y
B = BTN_B
A = BTN_A

LB = BTN_TL
RB = BTN_TR

TL = BTN_THUMBL
TR = BTN_THUMBR

[xboxdrv-daemon]
dbus=disabled
```