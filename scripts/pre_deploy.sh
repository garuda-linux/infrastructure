#!/usr/bin/env bash
# Language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Update system & install packages
pacman -Syu --noconfirm ansible yarn openssh

# Setup ssh
eval "$(ssh-agent -s)"
mkdir -p ~/.ssh
echo "$SSH_PRIVATE_KEY" >~/.ssh/id_rsa
echo "Host gitlab.com
UpdateHostKeys no" >~/.ssh/config
chmod -v 700 ~/.ssh && chmod 600 ~/.ssh/*

# Setup Ansible
ansible --version
echo "$ANSIBLE_VAULT" >ansible/.vault_pass
yarn install

# Fix permissions to allow Ansible runs
find "$(pwd)" -type f -exec chmod 644 {} \;
find "$(pwd)" -type d -exec chmod 755 {} \;

chmod +x -v node_modules/.bin/* scripts/*
