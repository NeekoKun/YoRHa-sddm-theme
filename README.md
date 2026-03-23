!! Blatanly stolen code from [SDDM Sugar Dark](https://github.com/MarianArit/sddm-sugar-dark) !!

## Previews
![Default Preview](./Previews/default.png)
![DE Select Preview](./Previews/de-select.png)

## Features
- The user will be shown with a **Capital Letter** regardless of the typed case, this is only a graphical effect
- Last logged in user will be used as text placeholder
- Random quotes will be fetched from the [Quotes Folder](./Quotes/)
    - The quote file selected can be changed in the [LoginForm.qml](./Components/LoginForm.qml)
    - Every line will be read as a single quote, everything after a tilde (~) will be considered as the source of the quote and will be placed in the bottom right
- Sound effects play on focus, button press and login (WIP)

## Installation
1. Copy the theme folder to `/usr/share/sddm/themes/`
2. Edit `/etc/sddm.conf` and set:
    ```
    [Theme]
        Current=YoRHa
    ```
3. Restart your display manager or reboot your system

**Optional:** To preview the theme before applying it, run:
```bash
sddm-greeter --test-mode --theme <theme root folder>
```