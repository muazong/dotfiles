# My Awesome configurations for a stupid laptop

> [!WARNING]
> These configurations may not work on your computer :) but you can still refer to it.

> [!NOTE]
> For window screen sharing:

```bash
sudo pacman -S pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland

systemctl --user restart pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland

yay -S xdg-desktop-portal-hyprland-git
alias gdisplay "env XDG_CURRENT_DESKTOP=gnome gnome-control-center display"
```
