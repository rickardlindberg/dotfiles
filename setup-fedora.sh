#!/usr/bin/env bash

set -e

sudo dnf upgrade

dependencies() {
    echo @multimedia
    echo kdenlive
    echo obs-studio

    echo git
    echo gitk
    echo mercurial
    echo vim
    echo gvim
    echo ack
    echo python3-wxpython4
    echo meld

    echo @i3
    echo fontawesome-fonts-all
    echo acpi
    echo arandr
    echo redshift-gtk

    echo supertuxkart
}

sudo dnf install $(dependencies)

# https://rpmfusion.org/Configuration
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# https://rpmfusion.org/Howto/Multimedia
# libavcodec-freeworld is meant to complement ffmpeg-free package. Not needed for ffmeg.
sudo dnf swap ffmpeg-free ffmpeg --allowerasing

fix_totem() {
    rm .cache/gstreamer-1.0/registry.x86_64.bin
}

list_rpm_fusion() {
    rpm -qa --qf "%{NAME} %{PACKAGER}\n" | grep "RPM Fusion" | cut -d\  -f1 | sort
}
