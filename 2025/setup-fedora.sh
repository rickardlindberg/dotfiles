#!/usr/bin/env bash

sudo dnf upgrade

sudo dnf install \
    @multimedia \
    @i3 \
    vim \
    gvim \
    kdenlive \
    supertuxkart \
    ack \
    python3-wxpython4 \
    gitk

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
