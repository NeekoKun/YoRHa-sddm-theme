## Warning
Broken system controls

## Previews

https://github.com/user-attachments/assets/e19d932b-0477-4889-8172-57c3c5406f8e


## Features
- The user will be shown with a **Capital Letter** regardless of the typed case, this is only a graphical effect
- Last logged in user will be used as text placeholder
- Random quotes will be fetched from the [Quotes Folder](./Quotes/)
    - The quote file selected can be changed in the [LoginForm.qml](./Components/LoginForm.qml)
    - Every line will be read as a single quote, everything after a tilde (~) will be considered as the source of the quote and will be placed in the bottom right
- Sound effects play on focus, button press and login (WIP)
- Scales to higher resolutions. If you have a 16:9 instead of a 16:10 monitor, change the height in the sizeHelper in [Main.qml](./Main.qml) from 1200 to 1080

## Structure

```
YoRHa-sddm-theme/
├── Components/
│   ├── Main.qml
│   ├── LoginForm.qml
│   ├── SystemControl.qml
│   ├── SystemInformations.qml
│   ├── Footer.qml
│   ├── Input.qml
│   ├── SessionButton.qml
│   └── SystemButtons
├── Quotes/
│   └── [quote files]
├── Fonts/
│   └── [fonts]
├── Previews/
│   ├── default.png
│   └── de-select.png
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
