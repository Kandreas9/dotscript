#!/bin/bash

echo "=========="
echo "Exept checking if you have inputed any text," 
echo "there is no sanitation, make sure to double check your username and your e-mail"
echo "=========="

read -p 'Username: ' username
read -p 'E-mail: ' useremail

if [[ ! -n $username ]]
then
  echo "===You did not input a username==="
  exit
fi

if [[ ! -n $useremail ]]
then
  echo "===You did not input an e-mail==="
  exit
fi

#Setup name and e-mail
git config --global user.name $username
git config --global user.email $useremail

#Enable merge conflict resolution memory
git config --global rerere.enabled true

#Create and populate global gitignore
cat <<EOF > ~/.gitignore_global
*.swp
*.swo
.DS_Store
deno.lock
EOF

#Assign global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo "=========="
echo "Your git setup has been configured ✅"
echo "Run 'git config --list' to see your git config settings"
echo "=========="
