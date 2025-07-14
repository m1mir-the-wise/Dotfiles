There are a few adjustments you probably need to do to make these dotfiles work correctly.

Check the monitor you use. You can do it with "xrandr", and alter the "Monitors" config in hyprland.conf.

Also in hyprland.conf, the default folder I set to save Screnshots is ~/Imagens/Screenshots. If you want it to save somewhere else, change the path in the keybind "bind = , PRINT, exec, hyprshot -m region --output-folder ~/Imagens/Screenshots"

In hypridle.conf, if you use a keyboard with backlight, check the name of your keyboard with "brightnessctl --list" and change in the file if necessary.
