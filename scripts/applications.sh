#!/bin/bash

# ===ADD ANY NEW LINKS YOU WOULD USE TO DOWNLOAD APPLICATIONS IN THE APPS LIST===

apps=(
  "https://discord.com/api/download?platform=osx"
  "https://iterm2.com/downloads/stable/latest"
  "https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64"
  "https://github.com/keepassxreboot/keepassxc/releases/download/2.7.9/KeePassXC-2.7.9-arm64.dmg"
  "https://getkap.co/api/download/arm64"
  "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.5/Obsidian-1.6.5.dmg"
)

# ===DO NOT EDIT BELOW CODE ===

if [[ $OSTYPE == 'darwin'* ]]
then
  mkdir "${PWD}/downloads"
  mkdir "${PWD}/unzipped"

  cd "${PWD}/downloads" || exit

  for oglink in "${apps[@]}"
  do
    echo "=========="
    echo "Preparing to install from ${oglink} 💻"
    echo "=========="
    regexDmg="*.dmg"
    regexZip="*.zip"

    if [[ $oglink == $regexDmg ]]
    then
      curl -LO ${oglink}
      continue
    fi

    if [[ $oglink == $regexZip ]]
    then
      curl -LO ${oglink}
      continue
    fi

    redirect=$(curl -Ls -I -o /dev/null -w %{url_effective} ${oglink})

    curl -LOJ ${redirect}
  done

  for filepath in "${PWD}"/*
  do
    #Test with [] test shorthand if file exist in directory
    if [ ! "$(ls -A)" ]
    then
      echo "===No files downloaded==="
      break
    fi

    filename=$(basename "$filepath")
    filename_non_ext="${filename%.*}"
    extension="${filename##*.}"

    case $extension in
      "dmg")
        echo "=========="
        echo "Preparing to mount volume 🗻"
        echo "=========="
        hdiutilAttach=$(hdiutil attach $filename)

        if [ $? -eq 0 ]
        then
          echo "===Mount successful==="
        else
          echo "===Mount unsuccessful==="
          continue
        fi

        regex='\/Volumes\/.*'

        if [[ $hdiutilAttach =~ $regex ]]; then
          dmgVolume="${BASH_REMATCH[0]}"
        fi

        volumeFileName=$(ls "${dmgVolume}" | grep '.app')

        appExists=$(find "/Applications/" -name "${volumeFileName}" -depth 1)

        #Chech with [] test shorthand if app is already installed
        if [ -n "$appExists" ]
        then
          echo "===${volumeFileName} already exists==="
          hdiutil detach "${dmgVolume}"
          continue      
        fi

        echo "=========="
        echo "Copying ${volumeFileName} in Applications 🚀"
        echo "=========="
        cp -pPR "${dmgVolume}/${volumeFileName}" /Applications

        if [ $? -eq 0 ]
        then
          echo "===Copy successful==="
        else
          echo "===Copy unsuccessful==="
          hdiutil detach "${dmgVolume}"
          continue
        fi

        echo "=========="
        echo "Preparing to detach volume 😒"
        echo "=========="
        hdiutil detach "${dmgVolume}" -quiet

        if [ $? -eq 0 ]
        then
          echo "===Unmount successful==="
        else
          echo "===Unmount unsuccessful==="
          continue
        fi
        ;;
      "zip")
        echo "=========="
        echo "Preparing to unzip ${filename_non_ext}"
        echo "=========="
        unzip -q $filename -d "${PWD%/*}/unzipped"

        if [ $? -eq 0 ]
        then
          echo "===Unzip successful==="
        else
          echo "===Unzip unsuccessful==="
        fi
        ;;
      "pkg")
        echo "This is a .pkg $filename"
        ;;
    esac
  done

  cd .. || exit
  #Clean up folder with all files inside
  rm -rf "${PWD}/downloads"


  cd "${PWD}/unzipped" || exit

  for unzippedApp in ${PWD}/*.app
  do
    #Test with [] test shorthand if file exist in directory
    if [ ! "$(ls -A)" ]
    then
      echo "===No files to unzip==="
      break
    fi

    echo "=========="
    echo "Copying all unzipped apps to Applications 🧳"
    echo "=========="

    unzippedFilename=$(basename "$unzippedApp")
    unzippedExists=$(find "/Applications/" -name "$unzippedFilename" -depth 1)

    #Chech with [] test shorthand if app is already installed
    if [ -n "$unzippedExists" ]
    then
      echo "===${unzippedFilename} already exists==="
      continue      
    fi

    cp -pPR $unzippedApp /Applications

    if [ $? -eq 0 ]
    then
      echo "===Unmount successful==="
    else
      echo "===Unmount unsuccessful==="
    fi
  done

  cd .. || exit
  #Clean up folder with all files inside
  rm -rf "${PWD}/unzipped"

  echo "=========="
  echo "You are ready to go hopefully ✅"
  echo "=========="
else
  echo "This script only works for mac, buy a mac"
fi
