#!/bin/bash
# Exit script if error
set -e

echo -e "\e[100mSetting timezone to:\e[49m"
echo "Europe/Stockholm" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

#############################################################

echo -e "\e[100mModifying prompt\e[49m"

echo -ne '...\r'
echo 'function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}") "
}' >> ~/.bashrc
echo -ne '......\r'
echo 'PS1="\[\033[48;5;244;38;5;255m\]\u@\h:\W \$(parse_git_branch)$\[\033[00m\] "' >> ~/.bashrc
echo -ne '..........\r'
echo -ne '\n'

#############################################################

echo -e "\e[100mUpgrading packages\e[49m"

sudo apt-get update
sudo apt-get -y upgrade

#############################################################

echo -e "\e[100mInstalling the Silver Searcher\e[49m"

sudo apt-get -y install silversearcher-ag

#############################################################

echo -e "\e[100mInstalling Git\e[49m"

sudo apt-get -y install git
touch ~/.ssh/known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

#############################################################

echo -e "\e[100mAdding repository to APT config\e[49m"
curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash

#############################################################

echo -e "\e[100mInstalling crystal\e[49m"
sudo apt-get install build-essential -y
sudo apt-get install crystal -y

# sudo echo LC_ALL=en_US.UTF-8 >> /etc/environment
# sudo echo LANG=en_US.UTF-8 >> /etc/environment

#############################################################

echo -e "\e[100mRemoving unnecessary packages, cleanup etc.\e[49m"

echo -e "\e[101mBefore:\e[49m"
sudo du -sh /var/cache/apt/archives
sudo apt-get remove --purge ubuntu-core-launcher -y
sudo apt autoclean
sudo apt-get clean
sudo apt autoremove
echo -e "\e[42mAfter:\e[49m"
sudo du -sh /var/cache/apt/archives

#############################################################
echo -e "\e[96mAll set up!"
echo -e "Commands used, and more, can be found here:"
echo -e "https://crystal-lang.org/docs/installation/on_debian_and_ubuntu.html\e[39m"
