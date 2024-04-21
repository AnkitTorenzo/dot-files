#!/bin/bash

## These are all the functions
exitTime ()
{
    echo "Since I have skill issues in bash. I am now terminating this script's execution."
    echo "Bye Bye..."
    exit 1
}

errorCheck()
{
    if [[ $? -ne 0 ]]; then
        echo "There was an error in the last command we just ran."
        echo "Terminating the execution before we do any further damage."
        exit 1
    else
        echo "---------------------------------------------------------------------------"
    fi
}
## Function declaration area complete

echo "This script is made for Arch and Arch based distro."
echo "Is your distro is Arch or Arch based?(y/N)"
read isArch

if [[ -z "$isArch" ]];
then
    exitTime
fi


if [[ $isArch -eq "y" || $isArch -eq "Y" ]]
then
    echo "Nice you use arch...!"
    echo "Let's continue ahead."
    echo "---------------------"
else
    exitTime
fi

## Here somes all the commands 

echo "updating all the packages...!"
sudo pacman -Syu
errorCheck

echo "Updating all the packages is complete..."
echo "----------------------------------------"

echo "Installing all the necessary packages for the configs...!"
echo "All the packages are listed in utils.list. Modify this file with the list of your own packages."
cat utils.list | sudo pacman -S -
errorCheck

echo "Installing oh-my-posh to make the prompt look fancy."
curl -s https://ohmyposh.dev/install.sh | bash -s
errorCheck

echo "Installing JetBrainsMono Nerd Fonts for Alacritty config."
oh-my-posh font install "JetBrainsMono"
errorCheck

echo "Installing Tmux Package Manager."
mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
errorCheck
echo "Tmux Plugin Manager is install all config plugins by [<prefix> + shift + i]"

echo "Cloning all the git submodules"
git submodule init
git submodule update

echo "For now all the configuration is dont."
echo "UNTIL NEXT TIME. Bye Bye...!👋"
