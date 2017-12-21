#!/usr/bin/env bash

# Some parts from http://kappataumu.com/articles/vagrant-jekyll-github-pages-streamlined-content-creation.html

start_seconds="$(date +%s)"
echo "Initializing dev environment on VM."

apt_packages=(
    vim
    curl
    wget
    git-core
    xorg
    nodejs
    # build-essential
    zip # to unzip netlify-git-api binary
)

ping_result="$(ping -c 2 8.8.4.4 2>&1)"
if [[ $ping_result != *bytes?from* ]]; then
    echo "Network connection unavailable. Try again later."
    exit 1
fi

# Needed for nodejs.
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sSL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo add-apt-repository -y ppa:git-core/ppa

echo ---Updating packages---
sudo apt-get update
sudo apt-get upgrade -y

echo ---Installing apt-get packages---
echo "Installing apt-get packages..."
sudo apt-get install -y ${apt_packages[@]}
sudo apt-get clean

echo ---Telling git to use CRLF for line endings \(Ahem, windows\!\)---
sudo git config --global core.autocrlf true
