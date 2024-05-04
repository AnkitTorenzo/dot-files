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
    if [[ $? -ne 0 ]];
    then
        printError "There was an error in the last command we just ran."
        printError "Terminating the execution before we do any further damage."
        exit 1
    else
        printSuccess "---------------------------------------------------------------------------"
    fi
}

askForBackup()
{
    echo "Make a backup, & continue. Ready TO Continue?(y/N)"
    read input

    if [[ -z "$input" ]];
    then
        echo "Terminating the process."
        exit 0
    elif [[ $input -eq "y" || $input -eq "Y" ]];
    then
        echo "Starting the cleanup...🧹🧹"
    else
        exit 1
    fi
}

checkForDirAndRemove()
{
    echo "Checking for $1"
    if [[ -f $1 || -L $1 ]];
    then
        echo "Found $1 : Removing the item"
        rm -rf $1
        errorCheck
    fi
}

printWarnning()
{
    Yellow="\033[0;33m"       # Yellow
    YellowEnd="\033[m"
    echo -e "$Yellow WARNNING!!! $1 $YellowEnd"
}

printError()
{
    Red="\033[0;31m"
    RedEnd="\033[m"
    echo -e "$Red ERROR!!! $1 $RedEnd"
}

printSuccess()
{
    Green="\033[0;32m"
    GreenEnd="\033[m"
    echo -e "$Green Success!!! $1 $GreenEnd"
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

printSuccess "Updating all the packages is complete..."
echo "----------------------------------------"

echo "Installing all the necessary packages for the configs...!"
echo "All the packages are listed in utils.list. Modify this file with the list of your own packages."
cat utils.list | sudo pacman -S -
errorCheck

echo "Setting-up the fish as a default default shell"
errorCheck

echo "Installing oh-my-posh to make the prompt look fancy."
#curl -s https://ohmyposh.dev/install.sh | bash -s
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

NvimConfig="~/.config/nvim/"
TmuxConfig="~/.config/tmux/"
AlacrittyConfig="~/.config/alacritty/"
FishConfig="~/.config/fish/"

echo "Well finally every thing is done, now it's time to Stow all the config files."
printWarnning "This step will remove the following existing configs dirs/sim-links. Make a backup before continuing."
echo $NvimConfig
echo $TmuxConfig
echo $AlacrittyConfig
echo $FishConfig
echo "--------------------------------------------------------------------------------------------------------------"
askForBackup
checkForDirAndRemove $NvimConfig
checkForDirAndRemove $TmuxConfig
checkForDirAndRemove $AlacrittyConfig
checkForDirAndRemove $FishConfig

echo "I've made sure, that there are no existing dirs/links. Sunning 'stow'"
stow .
errorCheck

echo "For now all the configuration is dont."
printSuccess "UNTIL NEXT TIME. Bye Bye...!👋"
