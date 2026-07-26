## Warning
Broken system controls

## Previews

https://github.com/user-attachments/assets/e19d932b-0477-4889-8172-57c3c5406f8e


## Features
- ~~The user will be shown with a **Capital Letter** regardless of the typed case, this is only a graphical effect~~
    - You can choose the capitalization through the [theme.conf](./theme.conf) file
- Last logged in user will be used as text placeholder
- Random quotes will be fetched from the [Quotes](./Components/Quotes.qml) module
    - The [Quotes](./Quotes/) Folder is now simply for reference and to store quotes you may want
- Sound effects play on button switch
- Scales to higher resolutions. If you have a 16:9 instead of a 16:10 monitor, change the height in the sizeHelper in [Main.qml](./Main.qml) from 1200 to 1080

## Structure

```
YoRHa-sddm-theme/
├── Assets/
│   ├── Icons
│   ├── sfx
│   └── [Images]
├── Components/
│   ├── ButtonBackground.qml
│   ├── ControlButtons.qml
│   ├── ControlPanel.qml
│   ├── Footer.qml
│   ├── Input.qml
│   ├── LoginForm.qml
│   ├── Main.qml
│   ├── Modal.qml
│   ├── PanelButton.qml
│   ├── Quotes.qml
│   └── SessionButton.qml
├── Fonts/
│   └── Rodin-Pro-M.otf
├── Previews/
│   └── preview.mp4
├── Quotes/
│   └── [quote files]
├── AUTHORS
├── CHANGELOG.md
├── CREDITS
├── metadata.desktop
├── TOFIX.md
├── ROADMAP.md
└── README.md
```

## Installation

### Manual Install
1. Clone the repository in `/usr/share/sddm/themes`
    ```bash
    cd /usr/share/sddm/themes
    git clone https://github.com/NeekoKun/YoRHa-sddm-theme
    ```

2. Edit `/etc/sddm.conf` and set:
    ```
    [Theme]
        Current=YoRHa-sddm-theme
    ```
3. Restart your display manager or reboot your system

**Optional:** To preview the theme before applying it, run:
```bash
sddm-greeter --test-mode --theme <theme root folder>
```

### AUR
Install `sddm-theme-yorha` with your favorite AUR helper

```bash
yay -S sddm-theme-yorha
```

```bash
paru -S sddm-theme-yorha
```

This will write a configuration script in `/etc/sddm.conf.d/YoRHa-sddm-theme.conf` which should set it as the default theme.

## Troubleshooting

### Bigger/Smaller text
The repo uses pointSize instead of pixelSize, so if
```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/YoRHa-sddm-theme
```
shows a correct pixel size, the X11 sddm session has a wrong/different DPI scale set. To change the DPI, edit `/etc/sddm.conf` and add
```bash
#...

[X11]
    ServerArguments=-dpi <your system dpi>
```

> [!TIP]
> To get you system DPI you can:
> - On X11
>   - Run `xdgyinfo | grep dots`
> - On Hyprland
>   - Run `hyprctl monitors`
>   - Get the `scale` field of the working monitor and multiply that by 100

### The wrong theme shows up
Probably another theme is conflicting in `/etc/sddm.conf`. check if the `Current` field is set anywhere other than `/etc/sddm.conf.d/YoRHa-sddm-theme.conf`