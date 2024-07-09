#!/bin/bash

cd ./scripts || exit

./install.sh
./applications.sh
./setupsyms.sh
./gitconfig.sh
