<h1 align="center">🪐 Martian Evolved</h1>

> [!WARNING]
> Works only for **Gentoo Linux**.  

## ⚙️ Get Started
- Clone repo

```
# Shallow clone
git clone --depth 1 https://github.com/zalosspace/martain_evolved.git && \
cd martian_evolved
```
- Run install.sh
```
# Give the install script execution permission
chmod +x install.sh && \

# Run the installer
./install.sh
```
> [!NOTE]
> install.sh will automatically store your current dotfiles at ~/ dir 
into two folders named backup.config and backup.home

- Restart Bspwm after changes
```
bspc wm -r
```
> [!IMPORTANT]
> Make sure to read every single line of scripts you find online before 
running it.

- If you have done the canon arc of crashing your setup here's how to fix it.
If you can't see anything then go into tty mode with `Ctrl + Alt + Funtion Key`
and then login there and then navigate to the martian_dotfiles dir and then
do the following:
```
# Restore Previous Rice
chmod +x restore_rice.sh

# Run The Script
./restore_rice.sh
```

## ⌨️ Essential Keybindings
> Alt is used as the main modifier in this setup

| Action              | Shortcut          |
|:-------------------:|:-----------------:|
| Switch Workspace    | Alt + 0 - 9     |
| Open Terminal	      | Alt + Enter     |
| App Launcher (Rofi) |	Alt + D         |
| Close window	      | Alt + Q         |
| Restart bspwm	      | Alt + Shift + R |
| Focus Window left, down, up, right | Alt + H, J, K, L |
| Move Window left, down, up, right | Alt + Shift H, J, K, L |

Look into `~/.config/sxhkd/sxhkdrc` for rest of the hotkeys.

--- 

## 🧩 What’s Inside
### Bspwm
*Bspwm* is a tiling window manager which uses binary space partition system.

---

### Sxhkd
*Sxhkd* is a simple hotkey daemon, that reacts to input events 
by executing commands. Unlike i3 WM you need a seperate keybinding (hotkey)
system inorder to make Bspwm work with your keyboard.

---

### SDDM (Simple Desktop Display Manager)
*Sddm* is a session manager.
#### What it does:
- **User login** – lets you pick your username and enter your password.
- **Session selection** – lets you choose a desktop environment or window manager (like bspwm, KDE, GNOME).
- **Autologin (optional)** – automatically logs in a user if configured.

---

### Polybar
*Polybar* is well a bar which you can configure to display information
like cpu usage, memory, date, volume, music visualizer, etc.

---

### Rofi
*Rofi* an app launcher, window switcher, run dialog and ssh-launcher.
#### What it can do:
- **App launcher**
Press your shortcut (like Alt/Super + D) → Rofi pops up → type the app 
name → Enter → boom, app opens.
- **Window switcher**
Shows all open windows, lets you pick which one to focus on.
- **Run commands**
You can bind Rofi to run shell commands.
Example: type reboot or make-coffee without opening a terminal.
- **Custom menus**
Make your own scripts or menu options.
Perfect for shortcuts that aren’t built into bspwm or sxhkd.

---

### Picom:
*Picom* is a standalone compositor for Xorg, suitable for use 
with window managers that do not provide compositing.
#### What it does:
- **Transparency**
You can use it to make apps/software transparent.
- **Shadows**
Soft depth so windows don’t feel like stickers on a wall.
- **Animations / fading**
Windows fade in and out instead of materializing out of thin air.
- **VSync / tear-free rendering**
No screen tearing when you move windows.

---

### Zsh:
*Zsh* is a command-line shell, a shell command interpreter which sits 
between you and the operating system, translating commands you wrote into
something the system can understand. 
#### What it does (better than Bash):
- **Smarter autocomplete**
Tab-complete commands, flags, paths — even with typos.
- **History that actually helps**
Type part of a previous command → Zsh remembers the rest.
- **File matching**
Powerful file matching.
- **Customization & themes**
Prompts, syntax-highlighting, colors, git status, icons.

---

### Kitty: 
**Kitty** is a terminal emulator. Terminal is a window where your shell lives.

---

## 🛠️ Modifying the Rice (Make It Yours)
This setup is meant to be edited, broken, and rebuilt.
Below are the safest places to start tweaking without nuking your system.

### 🎨 Colors & Aesthetics

#### Polybar 
Change colors, fonts, modules. Restart polybar after edits.
```
# Config
~/.config/polybar/config.ini

# Restart Polybar (run launch.sh)
~/.config/polybar/launch.sh
```

#### Rofi themes
.rasi files control colors, spacing, fonts.
```
# Config
~/.config/rofi/
```

#### Picom 
Transparency, shadows, animations live here.
```
# Config
~/.config/picom.conf
```

### 🪟 Window Behavior

#### Bspwm config 
Adjust gaps, borders, split ratios.
```
# Config
~/.config/bspwm/bspwmrc

# Restart safely with:
bspc wm -r
```

### ⌨️ Hotkeys
Every shortcut is just a command.
```
# Config
~/.config/sxhkd/sxhkdrc

# Reload without logout:
pkill sxhkd && sxhkd &
```

### 🐚 Shell & Terminal

#### Zsh 
Aliases, prompt, plugins.
```
# Config
~/.zshrc

# Open a new terminal to see changes
```
#### Kitty 
Font, padding, colors.
```
# Config
~/.config/kitty/kitty.conf

# Open a new terminal to see changes
```

> 🧪 Golden rule of ricing,
Change one thing at a time.
If it breaks, you’ll know exactly why.
