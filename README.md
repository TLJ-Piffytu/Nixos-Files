# Nixos Files
## Introduction
My nixos files for personal use. **Not a full DE**  
In development, expect changes!
## Installation  
Make sure to generate your hardware configurations first!  
**Do not overwrite hardware-configuration.nix**
### Clone the repository:
```git clone https://github.com/TLJ-Piffytu/Nixos-Files```
### Copy it to /etc/nixos:
```sudo cp -r Nixos-Files/Files/* /etc/nixos```
### Rebuild Nixos:
```sudo nixos-rebuild switch```
## Issues
You may need to fix permissons for the dotfiles. This mainly affects nvim and waybar.  
Several things are also broken or poorly written, these will be fixed soon
