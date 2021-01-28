#!/bin/bash
echo "setting up j3 as client on Raspberry Pi"
echo
echo "This script expects to be run on a freshly written RaspiOS Lite image"
echo
echo "The rpi should have an Internet connection and the user will have"
echo "issued the commad 'git clone https://github.com/charlesap/j3; cd j3/rpi"
echo

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y --no-install-recommends build-essential librtaudio-dev qt5-default autoconf automake libtool make libjack-jackd2-dev qjackctl audacity git
#(choose Yes in to allow user Realtime privieleges in Jackd)

pushd .
cd ../jacktrip; git submodule update
cd ../jamulus; git submodule update
cd ../jitsi-meet; git submodule update
popd


