# Hyprland Dotfiles

A complete Hyprland desktop configuration containing window rules, startup applications, keybindings, monitor profiles, wallpapers, animations, scripts, user configurations, and supporting configuration files.

This README is written so that someone who has **never used these dotfiles before** can clone the repository, install the required software, apply the configuration, start Hyprland, and troubleshoot common problems.

> **Repository:** `https://github.com/Bilalk0804/dotfiles`

---

## Table of Contents

* [What are dotfiles?](#what-are-dotfiles)
* [What is Hyprland?](#what-is-hyprland)
* [Repository Structure](#repository-structure)
* [Requirements](#requirements)
* [1. Install Hyprland](#1-install-hyprland)
* [2. Install Git](#2-install-git)
* [3. Clone the Repository](#3-clone-the-repository)
* [4. Enter the Repository](#4-enter-the-repository)
* [5. Back Up Existing Configuration](#5-back-up-existing-configuration)
* [6. Install the Dotfiles](#6-install-the-dotfiles)
* [7. Recommended Dependencies](#7-recommended-dependencies)
* [8. Make Scripts Executable](#8-make-scripts-executable)
* [9. Start Hyprland](#9-start-hyprland)
* [10. Reload Hyprland](#10-reload-hyprland)
* [11. Test the Configuration](#11-test-the-configuration)
* [12. Useful Hyprland Commands](#12-useful-hyprland-commands)
* [13. Useful Keybindings](#13-useful-keybindings)
* [14. Updating the Dotfiles](#14-updating-the-dotfiles)
* [15. Restoring Your Old Configuration](#15-restoring-your-old-configuration)
* [16. Troubleshooting](#16-troubleshooting)
* [17. Starting Hyprland Automatically](#17-starting-hyprland-automatically)
* [18. Creating a Clean Installation](#18-creating-a-clean-installation)
* [19. Git Commands for Maintaining the Dotfiles](#19-git-commands-for-maintaining-the-dotfiles)
* [20. Important Notes](#20-important-notes)

---

# What are dotfiles?

**Dotfiles** are configuration files used to customize Linux applications and the desktop environment.

For example:

```text
~/.config/hypr/
```

contains configuration files used by Hyprland.

Instead of manually configuring every computer, these files can be stored in Git and copied or linked to another machine.

This repository contains a collection of configurations designed to work together as a Hyprland desktop setup.

---

# What is Hyprland?

[Hyprland](https://hyprland.org/) is a dynamic tiling Wayland compositor.

It is responsible for managing:

* Windows
* Workspaces
* Keyboard shortcuts
* Monitors
* Window animations
* Window rules
* Startup applications
* Focus and movement
* Desktop behavior

The configuration is primarily controlled through files such as:

```text
hyprland.conf
```

and additional configuration files included by it.

---

# Repository Structure

The repository currently contains directories and configuration files similar to:

```text
dotfiles/
│
├── animations/
│
├── configs/
│   ├── ENVariables.conf
│   ├── Keybinds.conf
│   ├── Laptops.conf
│   ├── Startup_Apps.conf
│   ├── WindowRules-config-v3.conf
│   ├── WindowRules-F53.conf
│   ├── WindowRules.conf
│   └── ...
│
├── Monitor_Profiles/
│
├── scripts/
│
├── UserConfigs/
│
├── UserScripts/
│
├── wallpaper_effects/
│
├── wallust/
│
├── .initial_startup_done
│
├── application-style.conf
├── hypridle.conf
├── hyprland.conf
├── hyprlock-2k-2k.conf
├── hyprlock-1080p.conf
├── hyprlock.conf
├── initial-boot.sh
├── monitors.conf
├── workspaces.conf
└── ...
```

The exact contents can change as the repository evolves.

---

# Requirements

Before installing these dotfiles, you should have:

* A Linux system
* A Wayland-compatible graphics setup
* Hyprland
* Git
* A terminal
* A working internet connection

For the smoothest experience, an **Arch Linux or Arch-based distribution** is recommended.

Examples:

* Arch Linux
* CachyOS
* EndeavourOS
* ArcoLinux
* Other Arch-based distributions

Package names may differ on other distributions.

---

# 1. Install Hyprland

## Arch Linux

Update your system first:

```bash
sudo pacman -Syu
```

Install Hyprland:

```bash
sudo pacman -S hyprland
```

You may also want common Wayland utilities:

```bash
sudo pacman -S \
  waybar \
  wofi \
  kitty \
  dunst \
  wl-clipboard \
  grim \
  slurp \
  polkit-kde-agent \
  xdg-desktop-portal-hyprland
```

Install Git:

```bash
sudo pacman -S git
```

---

# 2. Install Git

If Git is not already installed:

```bash
sudo pacman -S git
```

Verify:

```bash
git --version
```

You should see something similar to:

```text
git version 2.x.x
```

---

# 3. Clone the Repository

Go to your home directory:

```bash
cd ~
```

Clone the repository:

```bash
git clone https://github.com/Bilalk0804/dotfiles.git
```

Verify that it was downloaded:

```bash
ls
```

You should see:

```text
dotfiles
```

---

# 4. Enter the Repository

Run:

```bash
cd ~/dotfiles
```

Check the files:

```bash
ls
```

For a detailed view:

```bash
find . -maxdepth 2 -type f
```

Check the Git status:

```bash
git status
```

You should see that you are currently on the repository's main branch.

---

# 5. Back Up Existing Configuration

**Do not overwrite your existing Hyprland configuration without making a backup.**

First check whether you already have a Hyprland configuration:

```bash
ls ~/.config/hypr
```

If it exists, create a backup:

```bash
mv ~/.config/hypr ~/.config/hypr.backup
```

Create the configuration directory:

```bash
mkdir -p ~/.config/hypr
```

Your old configuration is now available at:

```text
~/.config/hypr.backup
```

If you need to restore it later:

```bash
rm -rf ~/.config/hypr
mv ~/.config/hypr.backup ~/.config/hypr
```

---

# 6. Install the Dotfiles

There are two common ways to use these dotfiles.

## Method A — Copy the files

This is the easiest method for beginners.

From the repository:

```bash
cd ~/dotfiles
```

Copy the configuration files:

```bash
cp -r ./* ~/.config/hypr/
```

**Important:** This assumes the repository is intended to be used as the Hyprland configuration directory.

Before doing this on a system containing important files, inspect the repository first:

```bash
find ~/dotfiles -maxdepth 2 -type f
```

Then copy the required files.

---

## Method B — Use symbolic links

Symbolic links are recommended if you plan to actively develop and maintain the dotfiles.

Create the Hyprland configuration directory:

```bash
mkdir -p ~/.config/hypr
```

Create a backup:

```bash
cp -r ~/.config/hypr ~/.config/hypr.backup 2>/dev/null || true
```

Then link the repository:

```bash
ln -s ~/dotfiles/hyprland.conf ~/.config/hypr/hyprland.conf
```

If the configuration references files relative to the repository, make sure the referenced directories are also available at the expected paths.

Check the link:

```bash
ls -l ~/.config/hypr/hyprland.conf
```

You should see something similar to:

```text
hyprland.conf -> /home/your-user/dotfiles/hyprland.conf
```

---

# 7. Recommended Dependencies

The configuration may use external programs for:

* Status bars
* Application launchers
* Notifications
* Wallpapers
* Screenshots
* Clipboard management
* Lock screens
* Idle management
* Terminal applications
* Audio controls
* Brightness controls
* Network management

On Arch Linux, a useful starting set is:

```bash
sudo pacman -S \
  kitty \
  waybar \
  wofi \
  dunst \
  wl-clipboard \
  grim \
  slurp \
  brightnessctl \
  playerctl \
  networkmanager \
  pavucontrol \
  pipewire \
  pipewire-pulse \
  wireplumber
```

Enable NetworkManager:

```bash
sudo systemctl enable --now NetworkManager
```

Verify:

```bash
systemctl status NetworkManager
```

---

# Wallpaper Support

If the configuration uses `swww`, install it:

```bash
sudo pacman -S swww
```

Check:

```bash
swww --version
```

If the repository uses another wallpaper program, install the program referenced by the relevant script.

You can search the repository for commands:

```bash
grep -R "swww\|hyprpaper\|wallpaper" ~/dotfiles
```

---

# Audio Support

Check PipeWire:

```bash
systemctl --user status pipewire
```

Check PulseAudio compatibility:

```bash
systemctl --user status pipewire-pulse
```

Start them if necessary:

```bash
systemctl --user start pipewire
systemctl --user start pipewire-pulse
```

Check available audio devices:

```bash
wpctl status
```

---

# Clipboard Support

Install:

```bash
sudo pacman -S wl-clipboard
```

Test:

```bash
echo "Hello Hyprland" | wl-copy
```

Then paste it into another application.

---

# Screenshot Support

Install:

```bash
sudo pacman -S grim slurp
```

Example screenshot command:

```bash
grim screenshot.png
```

Select an area:

```bash
grim -g "$(slurp)" screenshot.png
```

---

# 8. Make Scripts Executable

The repository contains a `scripts/` directory and may contain additional shell scripts.

Check them:

```bash
find ~/dotfiles/scripts -type f
```

Make shell scripts executable:

```bash
find ~/dotfiles/scripts -type f -name "*.sh" -exec chmod +x {} \;
```

Do the same for `UserScripts` if necessary:

```bash
find ~/dotfiles/UserScripts -type f -name "*.sh" -exec chmod +x {} \;
```

For the initial boot script:

```bash
chmod +x ~/dotfiles/initial-boot.sh
```

Verify permissions:

```bash
ls -l ~/dotfiles/scripts
```

An executable script normally looks like:

```text
-rwxr-xr-x
```

The `x` means it can be executed.

---

# 9. Start Hyprland

## From a TTY

If you are not using a graphical display manager:

Press:

```text
Ctrl + Alt + F2
```

Log in.

Then run:

```bash
Hyprland
```

or:

```bash
exec Hyprland
```

If everything is configured correctly, the Hyprland desktop should start.

---

# Starting From a Display Manager

If you use a display manager such as SDDM or GDM, log out of your current desktop.

On the login screen, select the Hyprland session.

The exact menu depends on your display manager.

---

# 10. Reload Hyprland

After changing the configuration, you normally do **not** need to completely restart Hyprland.

Reload the configuration with:

```bash
hyprctl reload
```

If there is a configuration error, Hyprland will report it.

You can also inspect the configuration with:

```bash
hyprctl configerrors
```

This is one of the most useful commands when developing these dotfiles.

---

# 11. Test the Configuration

Check that Hyprland is running:

```bash
hyprctl version
```

Check monitors:

```bash
hyprctl monitors
```

Check workspaces:

```bash
hyprctl workspaces
```

Check connected clients/windows:

```bash
hyprctl clients
```

Check active window:

```bash
hyprctl activewindow
```

Check active workspace:

```bash
hyprctl activeworkspace
```

Check configuration errors:

```bash
hyprctl configerrors
```

---

# 12. Useful Hyprland Commands

## Reload configuration

```bash
hyprctl reload
```

## Exit Hyprland

```bash
hyprctl dispatch exit
```

## Open a terminal

```bash
hyprctl dispatch exec kitty
```

Replace `kitty` with your preferred terminal.

## Move the active window

```bash
hyprctl dispatch movewindow l
```

Other directions:

```bash
hyprctl dispatch movewindow r
hyprctl dispatch movewindow u
hyprctl dispatch movewindow d
```

## Change workspace

```bash
hyprctl dispatch workspace 1
```

For workspace 2:

```bash
hyprctl dispatch workspace 2
```

## Move a window to another workspace

```bash
hyprctl dispatch movetoworkspace 2
```

## Toggle fullscreen

```bash
hyprctl dispatch fullscreen
```

## Toggle floating

```bash
hyprctl dispatch togglefloating
```

## Center the active window

```bash
hyprctl dispatch centerwindow
```

## Kill the active window

```bash
hyprctl dispatch killactive
```

Use this carefully.

---

# Useful Information Commands

## Hyprland version

```bash
hyprctl version
```

## Monitor information

```bash
hyprctl monitors
```

## Detailed monitor information

```bash
hyprctl monitors all
```

## Workspace information

```bash
hyprctl workspaces
```

## Window/client information

```bash
hyprctl clients
```

## Keybind information

```bash
hyprctl binds
```

## Active window

```bash
hyprctl activewindow
```

## Active workspace

```bash
hyprctl activeworkspace
```

## System information

```bash
uname -a
```

For hardware information:

```bash
lspci
```

For graphics information:

```bash
lspci | grep -E "VGA|3D|Display"
```

---

# 13. Useful Keybindings

The exact keybindings are defined by the repository's:

```text
configs/Keybinds.conf
```

Do not assume the shortcuts below are exactly the same as the configuration.

To inspect the configured keybindings:

```bash
cat ~/dotfiles/configs/Keybinds.conf
```

Or:

```bash
less ~/dotfiles/configs/Keybinds.conf
```

You can also ask Hyprland:

```bash
hyprctl binds
```

---

# Common Hyprland Concepts

## `$mainMod`

Hyprland configurations commonly define:

```text
$mainMod = SUPER
```

`SUPER` normally means the Windows/Meta key.

For example:

```text
SUPER + Enter
```

might open a terminal.

---

## Workspaces

Workspaces are separate virtual desktops.

For example:

```text
Workspace 1 → Main work
Workspace 2 → Browser
Workspace 3 → Development
Workspace 4 → Communication
```

The actual workspace configuration can be found in:

```text
workspaces.conf
```

---

## Window Rules

Window rules control how individual applications behave.

The repository contains files such as:

```text
configs/WindowRules.conf
configs/WindowRules-config-v3.conf
configs/WindowRules-F53.conf
```

These can control things such as:

* Floating windows
* Window size
* Window position
* Workspace assignment
* Opacity
* Layer behavior
* Application-specific behavior

---

## Startup Applications

Startup applications are configured in:

```text
configs/Startup_Apps.conf
```

This is where you should look if an application is automatically launched when Hyprland starts.

For example, you may find commands similar to:

```text
exec-once = ...
```

---

## Environment Variables

Environment variables are configured in:

```text
configs/ENVariables.conf
```

These can affect:

* Wayland applications
* Electron applications
* Qt applications
* GTK applications
* NVIDIA/AMD/Intel behavior
* XWayland

---

## Monitor Configuration

Monitor-related configuration can be found in:

```text
monitors.conf
```

and:

```text
Monitor_Profiles/
```

If you move the dotfiles to another computer, **check the monitor configuration first**.

A configuration designed for one monitor resolution may not be appropriate for another.

---

# 14. Updating the Dotfiles

Go to the repository:

```bash
cd ~/dotfiles
```

Check your current state:

```bash
git status
```

Download the latest changes:

```bash
git pull
```

If the update succeeds, reload Hyprland:

```bash
hyprctl reload
```

Check for errors:

```bash
hyprctl configerrors
```

---

# If You Modified the Files Yourself

Before running:

```bash
git pull
```

check:

```bash
git status
```

If you have local changes, Git may prevent the update.

You can see exactly what changed:

```bash
git diff
```

If you want to keep your changes, commit them:

```bash
git add .
git commit -m "Update local Hyprland configuration"
git pull
```

---

# 15. Restoring Your Old Configuration

If the new configuration causes problems and you created a backup earlier:

```bash
rm -rf ~/.config/hypr
```

Restore the backup:

```bash
mv ~/.config/hypr.backup ~/.config/hypr
```

Then start Hyprland again.

If Hyprland is currently running, you can try:

```bash
hyprctl reload
```

---

# 16. Troubleshooting

## Hyprland Does Not Start

First run:

```bash
Hyprland
```

from a TTY instead of starting it through a display manager.

This allows you to see errors directly.

---

## Check Configuration Errors

Run:

```bash
hyprctl configerrors
```

If Hyprland cannot fully load the configuration, inspect the output carefully.

---

## Check the Main Configuration

Open:

```bash
nano ~/.config/hypr/hyprland.conf
```

or:

```bash
vim ~/.config/hypr/hyprland.conf
```

Look for invalid paths or missing files.

---

## Check Included Configuration Files

Hyprland configurations commonly contain lines such as:

```text
source = ~/.config/hypr/configs/Keybinds.conf
```

If the referenced file does not exist, the configuration may fail.

Check:

```bash
find ~/.config/hypr -type f
```

---

## Check File Permissions

Run:

```bash
ls -la ~/.config/hypr
```

For scripts:

```bash
find ~/.config/hypr -type f -name "*.sh" -exec ls -l {} \;
```

Make scripts executable:

```bash
find ~/.config/hypr -type f -name "*.sh" -exec chmod +x {} \;
```

---

## Application Does Not Open

First check whether the program exists.

For example:

```bash
which kitty
```

If nothing is returned, install it:

```bash
sudo pacman -S kitty
```

For another application:

```bash
which <application>
```

Example:

```bash
which waybar
```

---

## Waybar Does Not Start

Check whether it is installed:

```bash
which waybar
```

Start it manually:

```bash
waybar
```

If it produces an error, read the error output.

You can also check the process:

```bash
pgrep -a waybar
```

---

## Wallpaper Does Not Start

Check which wallpaper program the configuration uses:

```bash
grep -R "swww\|hyprpaper\|wallpaper" ~/.config/hypr
```

Check whether the program is installed:

```bash
which swww
```

or:

```bash
which hyprpaper
```

---

## Keybind Does Not Work

Check the configuration:

```bash
grep -n "bind" ~/.config/hypr/configs/Keybinds.conf
```

Or list Hyprland's active bindings:

```bash
hyprctl binds
```

Then verify that the application referenced by the keybind exists.

---

## Monitor Resolution Is Wrong

Check your monitor:

```bash
hyprctl monitors
```

Pay attention to:

```text
name
resolution
refresh rate
position
scale
```

Then inspect:

```bash
cat ~/.config/hypr/monitors.conf
```

and:

```bash
ls ~/.config/hypr/Monitor_Profiles/
```

A monitor profile made for another computer may need to be changed.

---

## External Monitor Is Not Detected

Check:

```bash
hyprctl monitors
```

If the monitor is not listed, check the physical connection and graphics drivers before modifying the Hyprland configuration.

---

# Logs

If something is not working, collect basic system information:

```bash
hyprctl version
```

```bash
hyprctl monitors
```

```bash
hyprctl configerrors
```

```bash
journalctl --user -b | grep -i hypr
```

For the current boot:

```bash
journalctl --user -b
```

---

# 17. Starting Hyprland Automatically

If you use a display manager, select the Hyprland session from its login screen.

If you want to start Hyprland from a TTY, you can use a shell startup condition.

For example, with Bash:

```bash
nano ~/.bash_profile
```

A typical setup can use:

```bash
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec Hyprland
fi
```

This starts Hyprland automatically when logging into TTY1.

**Do not blindly add this if you already have another display manager or session startup mechanism.**

---

# 18. Creating a Clean Installation

If you want to completely reinstall these dotfiles:

## Step 1 — Remove the current configuration

```bash
rm -rf ~/.config/hypr
```

## Step 2 — Clone the repository again

```bash
cd ~
rm -rf ~/dotfiles
git clone https://github.com/Bilalk0804/dotfiles.git
```

## Step 3 — Enter the repository

```bash
cd ~/dotfiles
```

## Step 4 — Inspect the files

```bash
find . -maxdepth 2 -type f
```

## Step 5 — Create the configuration directory

```bash
mkdir -p ~/.config/hypr
```

## Step 6 — Copy the configuration

```bash
cp -r ./* ~/.config/hypr/
```

## Step 7 — Make scripts executable

```bash
find ~/.config/hypr -type f -name "*.sh" -exec chmod +x {} \;
```

## Step 8 — Start Hyprland

```bash
Hyprland
```

---

# 19. Git Commands for Maintaining the Dotfiles

## Check repository status

```bash
git status
```

## See changed files

```bash
git diff --name-only
```

## See detailed changes

```bash
git diff
```

## Add all changes

```bash
git add .
```

## Commit changes

```bash
git commit -m "Update Hyprland configuration"
```

## Push changes

```bash
git push
```

## Pull changes

```bash
git pull
```

## See commit history

```bash
git log --oneline
```

## See the current branch

```bash
git branch
```

## See the remote repository

```bash
git remote -v
```

---

# Recommended Workflow for Changing the Dotfiles

When modifying the configuration, use this workflow:

```bash
cd ~/dotfiles
```

Check the current state:

```bash
git status
```

Edit the configuration:

```bash
nano hyprland.conf
```

Reload Hyprland:

```bash
hyprctl reload
```

Check for errors:

```bash
hyprctl configerrors
```

If everything works:

```bash
git add .
```

Commit:

```bash
git commit -m "Update Hyprland configuration"
```

Push:

```bash
git push
```

This makes it easy to recover your configuration if something goes wrong.

---

# Useful Quick Commands

Here is a quick reference for daily use.

### Go to dotfiles

```bash
cd ~/dotfiles
```

### Update dotfiles

```bash
git pull
```

### Reload Hyprland

```bash
hyprctl reload
```

### Check errors

```bash
hyprctl configerrors
```

### Check monitors

```bash
hyprctl monitors
```

### Check workspaces

```bash
hyprctl workspaces
```

### Check windows

```bash
hyprctl clients
```

### Check keybindings

```bash
hyprctl binds
```

### Check active window

```bash
hyprctl activewindow
```

### Check Hyprland version

```bash
hyprctl version
```

### Exit Hyprland

```bash
hyprctl dispatch exit
```

---

# 20. Important Notes

## Do not blindly copy configuration files

Hyprland configurations can contain hardware-specific settings.

In particular, check:

```text
monitors.conf
Monitor_Profiles/
configs/Laptops.conf
configs/ENVariables.conf
```

before using the configuration on different hardware.

---

## Check paths

Some configuration files may reference paths specific to the original system.

Search for home-directory references:

```bash
grep -R "/home/" ~/dotfiles
```

Search for usernames:

```bash
grep -R "$USER" ~/dotfiles
```

Search for potentially missing commands:

```bash
grep -R "exec\|exec-once" ~/dotfiles
```

---

# Security Considerations

Before executing any script downloaded from the internet, inspect it.

For example:

```bash
less ~/dotfiles/initial-boot.sh
```

Inspect scripts:

```bash
find ~/dotfiles -type f -name "*.sh"
```

Then read a particular script:

```bash
less ~/dotfiles/scripts/<script-name>.sh
```

Only execute scripts that you understand and trust.

---

# First-Time Installation — Quick Version

For an experienced Arch Linux user, the basic process is:

```bash
sudo pacman -Syu
```

```bash
sudo pacman -S git hyprland kitty waybar wofi dunst wl-clipboard grim slurp brightnessctl playerctl
```

```bash
cd ~
```

```bash
git clone https://github.com/Bilalk0804/dotfiles.git
```

```bash
cd ~/dotfiles
```

Back up the existing configuration:

```bash
mv ~/.config/hypr ~/.config/hypr.backup 2>/dev/null || true
```

Create the configuration directory:

```bash
mkdir -p ~/.config/hypr
```

Copy the configuration:

```bash
cp -r ./* ~/.config/hypr/
```

Make scripts executable:

```bash
find ~/.config/hypr -type f -name "*.sh" -exec chmod +x {} \;
```

Start Hyprland:

```bash
Hyprland
```

After making configuration changes:

```bash
hyprctl reload
```

Check for errors:

```bash
hyprctl configerrors
```

---

# Useful Debugging Checklist

When something does not work, run these commands in order:

```bash
hyprctl version
```

```bash
hyprctl configerrors
```

```bash
hyprctl monitors
```

```bash
hyprctl workspaces
```

```bash
hyprctl clients
```

```bash
hyprctl binds
```

Then check whether the required applications exist:

```bash
which kitty
which waybar
which wofi
which dunst
```

Finally inspect the logs:

```bash
journalctl --user -b | grep -i hypr
```

---

# Philosophy of This Repository

The goal of these dotfiles is to make a Hyprland setup:

* Reproducible
* Easy to customize
* Easy to backup
* Easy to move to another machine
* Easy to maintain with Git
* Modular through separate configuration files
* Friendly for both new and experienced Hyprland users

If you are new to Hyprland, **do not change everything at once**.

Start with:

```text
hyprland.conf
```

Then learn:

```text
configs/Keybinds.conf
```

Then:

```text
configs/Startup_Apps.conf
```

Then:

```text
configs/WindowRules.conf
```

Finally explore:

```text
Monitor_Profiles/
scripts/
UserConfigs/
UserScripts/
wallpaper_effects/
wallust/
```

This will make it much easier to understand how the complete desktop environment works.

---

# Contributing / Saving Your Own Changes

If you make a useful change:

```bash
cd ~/dotfiles
```

```bash
git status
```

```bash
git add .
```

```bash
git commit -m "Describe your change"
```

```bash
git push
```

Keep commits descriptive. Examples:

```text
Add laptop monitor profile
Fix terminal keybinding
Update window rules
Add wallpaper script
Fix startup application
Update Waybar configuration
```

---

# Final Quick Reference

```bash
# Clone
git clone https://github.com/Bilalk0804/dotfiles.git

# Enter repository
cd ~/dotfiles

# Inspect files
find . -maxdepth 2 -type f

# Backup existing Hyprland config
mv ~/.config/hypr ~/.config/hypr.backup

# Create config directory
mkdir -p ~/.config/hypr

# Copy configuration
cp -r ./* ~/.config/hypr/

# Make scripts executable
find ~/.config/hypr -type f -name "*.sh" -exec chmod +x {} \;

# Start Hyprland
Hyprland

# Reload configuration
hyprctl reload

# Check configuration errors
hyprctl configerrors

# Check monitors
hyprctl monitors

# Check workspaces
hyprctl workspaces

# Check windows
hyprctl clients

# Check keybindings
hyprctl binds

# Update repository
cd ~/dotfiles
git pull
```

---

## Credits

**Dotfiles:** BilalK0804

**Repository:** `BilalK0804/dotfiles`

**Desktop:** Hyprland

**Platform:** Linux / Wayland

---

## License

If you publish these dotfiles publicly, add the license you want to use here.

For example:

```text
MIT License
```

or specify that the repository is currently unlicensed.

---

**If something breaks, don't panic.**

Start with:

```bash
hyprctl configerrors
```

then:

```bash
hyprctl monitors
```

and finally:

```bash
journalctl --user -b | grep -i hypr
```

These three commands will usually provide the first information needed to diagnose a Hyprland configuration problem.
