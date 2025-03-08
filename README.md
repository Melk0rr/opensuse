# OpenSUSE
## Description
My config files for OpenSUSE Tumbleweed

## Branches
One branch per distro

## Requirements
### git
```shell
  sudo zypper in git
```
### GNU stow
```shell
  sudo zypper in stow
```

## Installation
1. Git clone the repo in your home folder
   ```shell
   cd
   git clone https://github.com/Melk0rr/dotfiles
   cd dotfiles
   ```
2. Checkout the branch you want depending on the distro you're on
   ```shell
   git checkout opensuse
   ```
3. Deploy the files using Stow
   ```shell
   stow .
   ```
  
