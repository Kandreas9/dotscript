#!/bin/bash
source ~/.zprofile

#Update rosetta if on arm
if [[ $(uname -m) == 'arm64' ]]
then
  if /usr/bin/pgrep -q oahd
  then 
    echo '===Rosetta 2 is already installed==='
  else
    softwareupdate --install-rosetta
  fi
fi

if ! command -v brew &>/dev/null
then
  #Install brew
  echo “==========”
  echo "Preparing to install brew ⏳"
  echo “==========”
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  #Add brew to PATH
  if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile
  then
    echo “==========”
    echo "Adding brew to .zprofile 💻"
    echo “==========”
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
  else
    echo “==========”
    echo "Brew already in .zprofile 🎬"
    echo “==========”
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"
  
  brew -v
  brew analytics off
  brew analytics state
else
  echo “==========”
  echo "Brew is already installed ✅"
  echo “==========”
  brew -v
fi

#Update Brew
echo “==========”
echo "Preparing to update brew 📤"
echo “==========”
brew update

#Add or remove any brew formulae here
for formula in bat starship eza fnm tlrc fzf dust trash neovim git
do
  echo "=========="
  echo "Preparing to install ${formula}"
  echo "=========="

  brew install "${formula}"
done

#The next three cask installations with brew are my three exceptions.
#I wouldn't recommend using brew for casks/applications,
#but these two would be harder to install without,
#and they do seem to be supported for brew so they shouldn't cause issues

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

echo “==========”
echo "Script has finished"
echo “==========”

brew -v
brew doctor
