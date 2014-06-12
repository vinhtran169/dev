#!/bin/bash

# Setup initial working environment for host machines. This initial script only serves Ubuntu.
#
# install git
# install virtualbox-4.2.10
# install vagrant 1.2.2

function command_exists() {
    type "$1" &> /dev/null;
}

distributor_id=`command_exists lsb_release && lsb_release -i`

if [[ "$distributor_id" != *Ubuntu* ]]; then
    echo "You're not on Ubuntu. This script is currently provided to run under Ubuntu only."
    exit 1
fi

is_32_bit=true
virtualbox_link=http://download.virtualbox.org/virtualbox/4.3.12/virtualbox-4.3_4.3.12-93733~Ubuntu~precise_i386.deb
vagrant_link=https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.2_i686.deb

function determine_32_64_bit() {
    local machine=$(uname -m)
    if ! [[ $machine =~ i686 ]] ; then
        is_32_bit=false
    fi
}

determine_32_64_bit

if ! $is_32_bit ; then
    echo "installing packages of 64-bit virtualbox and vagrant..."
    virtualbox_link=http://download.virtualbox.org/virtualbox/4.3.12/virtualbox-4.3_4.3.12-93733~Ubuntu~precise_amd64.deb
    vagrant_link=https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.2_x86_64.deb
fi


function install_git() {
    sudo apt-get install git
}

function install_virtualbox() {
    cd /tmp
    wget $virtualbox_link
    sudo dpkg -i virtualbox-4.3_4.3.12-93733~Ubuntu~precise*
    cd -
}

function install_vagrant() {
    cd /tmp
    wget $vagrant_link
    sudo dpkg -i vagrant_1.6.2*
    cd -
}

sudo apt-get update
install_git
install_virtualbox
install_vagrant
