# Dotscript

A set of scripts to automate the setup of my development environment effortlessly.
 
> :warning: Please do read the entire README to make sure you understand how everything works. This project is meant mostly for me to use, nonetheless I will do my best to give as much detail as I possibly can. **DO NOT CHANGE OR ADD** anything on this project once you clone it, unless you understand what you are doing or it is mentioned in [Customization](#customization).

For a lot more detail on why I made certain choices for this project and deeper customization have a look at my [blog post](https://www.smor.dev).

## Table of Contents

- [Supported Platforms](#supported-platforms)
- [File Structure](#file-structure)
- [Setup](#setup)
- [Customization](#customization)
- [Default Programs and Applications](#default-programs-and-applications)
- [In Case of ERRORS](#in-case-of-errors)
- [Footnotes](#footnotes)

## Supported Platforms

| MacOS | Everything Else |
| :---: | :-------------: |
| ✅ | ❌ |

Tested Versions:

![Static Badge](https://img.shields.io/badge/MacOS-Sonoma_14.5-lightgreen)

## File Structure

The top level of this repository contains:

Three folders:

- **nvim** :point_right: This folder contains all the dot/configuration files for neovim.[^1]
- **zsh** :point_right: This folder contains all the dot/configuration files for zsh.[^2]
- **scripts** :point_right: All of the automation power comes from the four scripts inside of this folder.

One bash script:

> :warning: The `setup.sh` script has not been tested yet. It most probably works just fine but I will leave this warning until I have specifically tested it in it's entirety.

- **setup.sh** :point_right: This script runs all the other scripts in the `/scripts` folder.

## Setup

Clone all the files from the Github repository:

```bash
git clone git@github.com:Kandreas9/dotscript.git
```

The intended usage is to use the `setup.sh` script at the top level of the repository, despite that until I have tested the `setup.sh` script to a bigger extent then I would recommend running all four scripts in the `/scripts` folder one by one in this order specifically:

> :warning: Before you can run any of the 5 scripts that are included in the project you have to give them executable permission potentially. If a script can't run after you just clone the project then go ahead and run this command for each script `chmod +x /path/to/script.sh` while replacing the path to the path of each of the scripts installed in your computer. **Be very careful** when adding any permissions or running any scripts. Do not trust me or anyone and make sure you do your own research for safety reasons. 

1. **install.sh** :point_right: This bash script does a few things. 
	- First it installs Rosetta 2 if it hasn't already been installed. 
	- Next if brew isn't installed, brew will be installed (If you haven't installed the x-code tools yet, while brew tries to be installed it will prompt to get the x-code tools as well).
	- Finally it will install all the packages for brew in a given list inside of the bash script.
2. **applications.sh** :point_right: This bash script contains a list of links which get used to install and setup all the applications i.g. discord, docker desktop, etc.
3. **setupsyms.sh** :point_right: This bash script sets up the symlinks[^3] for the dotfiles.

> :warning: Once you run all these scripts, specifically the `setupsyms.sh` script, you will not be able to move the projects files to different locations, otherwise the symlinks that got setup will break.

4. **gitconfig.sh** :point_right: The most useless script of the four currently, all it does is setup a few git configurations.

After everything is set up, open the terminal you have installed or the default terminal installed, which is already in the script, in this case it is iTerm2 and change the terminal font to be the new installed Fira Code Nerd Font[^4]

## Customization

As mentioned before this project was made personally for me and my setup.

If you are crazy enough to want to use this project and customize it to your liking then here are some tips.

1. **install.sh**

In this script you can add or remove any brew formulae[^5] at this part of the code:

```bash
#Add or remove the brew formulae names from the list in the below line
for formulae in bat starship eza fnm tlrc fzf dust trash neovim git
do
  echo "=========="
  echo "Preparing to install ${formulae}"
  echo "=========="

  brew install "${formulae}"
done

```

This script also installs a few brew casks[^6], one for the nerd font, another for raycast and ungoogled chromium. You can either remove, comment them out, change them, or keep them depending on your needs:

```bash
echo "=========="
echo "Preparing to install fira code nerd font (required for some formulae)"
echo "=========="
brew install --cask font-fira-code-nerd-font

echo "=========="
echo "Preparing to install raycast (better spotlight)"
echo "=========="
brew install --cask raycast

echo "=========="
echo "Preparing to install ungoogled chromium"
echo "=========="
brew install --cask eloston-chromium
```

2. **applications.sh**

It's fairly simple to customize this script. Theres a list at the top of the scripts code called `apps` and all you have to do to customize it is delete the links inside that list for the applications you do not want, and add the links to download the application you do need (generally I do this by copying the link from the download button on official sites for the applications I require).

> :warning: The application script currently only works with applications that are packaged either in `.dmg` or `.zip`.

```bash
# ===ADD ANY NEW LINKS YOU WANT TO USE TO DOWNLOAD APPLICATIONS IN THE APPS LIST===

apps=(
  "https://discord.com/api/download?platform=osx"
  "https://iterm2.com/downloads/stable/latest"
  "https://getkap.co/api/download/arm64"
  "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.5/Obsidian-1.6.5.dmg"
  #Add your links here and or remove previous links
)

```

3. **setupsyms.sh**

Ideally you won't ever have to touch this file, unless you would like to add new symlinks for new dotfiles that you want them to be in `~/.config`. If you want to do that, then you would reuse the line below to delete the symlink if it exists and the line below that creates the symlink.

```bash
#Remove previous files or symlinks
rm -ri ~/.config/zsh
rm -ri ~/.config/nvim

#Add symlinks
ln -s "${PWD%/*}"/zsh ~/.config/zsh
ln -s "${PWD%/*}"/nvim ~/.config/nvim
```

4. **gitconfig.sh**

This file you can change almost completely if you want by adding or removing git configuration commands, here is an example:

```bash
git config --global rerere.enabled true
```

## Default Programs and Applications

You can remove or add anything you want by following the [Customization](#customization) section. But the defaults that I have setup for my personal setup are:

CLI Programs:

- bat :point_right: `cat` alternative
- starship :point_right: shell prompt
- eza :point_right: `ls` alternative
- fnm :point_right: A node version manager
- tlrc :point_right: `tlrc`is the brew name for `tldr`, a simplistic `man` alternative
- fzf :point_right: A command line fuzzy search
- dust :point_right: `du` alternative
- trash :point_right: A safer way to delete files
- neovim :point_right: Keyboard based command line text editor
- git :point_right: Good ol git, a version control system

Applications:

- Discord :point_right: Gamer centric online chat
- iTerm2 :point_right: MacOS terminal
- Docker :point_right: Tools to containerize
- Keepassxc :point_right: Password manager
- Kap :point_right: MacOS screen recording
- Obsidian :point_right: Note taking app
- Ungoogled Chromium :point_right: Browser
- Raycast :point_right: Spotlight alternative

Font:

- Fira code nerd font :point_right: Its a font (If you want a different one, I recommend sticking with nerd fonts)

## In Case of ERRORS

I am also human, the scripts work on my machine and I have done my best to consider as many edge cases as I can. If a script fails or doesn't produce the expected output, here is a list of steps you can follow:

1. If the `install.sh` script fails, you might want to:
	- Delete the `~/.zprofile` if it has been created (not necessary but if you wanna remove everything and start fresh).
	- Delete brew in its entirety[^7].
	
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```
	
2. If the `applications.sh` script fails (script that would be more likely to fail if any of them fail), then you might want to:
	- In the directory that the `/scripts` is placed (this depends on where you cloned the repo) you might have to manually delete two temp folders and all their contents that are created by the script `/scripts/downloads` and `/scripts/unzipped`.
	- Unmount or eject any volumes that have popped up either on your desktop or from your `Disk Utility`.
	- Delete any applications in the `/Applications` folder that were installed by the script.
3. If the `setupsyms.sh` script fails, then you might want to:
	- Delete the entire `~/.config` folder or if you already have other configs inside it then delete the `~/.config/zsh` and `~/.config/nvim` folders, which are symlinks to the script.
	- Delete any zsh dotfiles you want in the root directory e.g. `~/.zshrc`.
4. If the `gitconfig.sh` script fails, which really shouldn't happen ever, but anyways then you might want to:
	- Delete the `~/.gitconfig` and the `~/.gitignore_global`.
5. Finally, unless you can figure out the problem, fix it yourself and rerun the scripts in the correct order. Go ahead and create an issue or a discussion in this repo and I will try to have a look at it when I get the time.

### Footnotes

[^1]: A fork of vim, a keyboard based text editor -> https://neovim.io/
[^2]: A Unix shell alternative to other popular shells like bash -> https://zsh.sourceforge.io/
[^3]: Symlinks explanation
[^4]: https://iterm2.com/documentation-fonts.html
[^5]: Homebrew package definition that builds from upstream sources https://docs.brew.sh/Formula-Cookbook#homebrew-terminology
[^6]: Homebrew package definition that installs macOS native applications https://docs.brew.sh/Formula-Cookbook#homebrew-terminology
[^7]: https://docs.brew.sh/FAQ#how-do-i-uninstall-homebrew
