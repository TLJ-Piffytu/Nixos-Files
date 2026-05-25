# Nixos Files
## Introduction
My nixos files for personal use. **Not a full DE**  
In development, expect changes!
## Installation  
Make sure to generate your hardware configurations first!  
**Do not overwrite hardware-configuration.nix**
### Clone the repository:
```bash
git clone https://github.com/TLJ-Piffytu/Nixos-Files
```
### Copy files to the respective directory
```bash
sudo cp -r Nixos-Files/nixos/* /etc/nixos
# fix ownership
sudo chown root /etc/nixos/*

cp -r Nixos-Files/dotconfig/* ~/.config

cp -r Nixos-Files/dotlocalbin/* ~/.local/bin
```  
**Note:** You may want to add ~/.local/bin to your $PATH if you haven't already
### Rebuild Nixos:
```bash
sudo nixos-rebuild switch
```
## Issues
You may need to fix permissions for the dotfiles. This mainly affects nvim and waybar.  
Several things are also broken or poorly written, these will be fixed soon
