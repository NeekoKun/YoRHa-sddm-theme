## Warning
Broken system controls

## Previews
[preview](./Previews/preview.mp4)

## Features
- The user will be shown with a **Capital Letter** regardless of the typed case, this is only a graphical effect
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
