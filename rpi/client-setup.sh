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

if [ ! -f passchanged ] ; then
	echo "Please change the root password (if you have not already)"
	sudo passwd root
	RR=$?
	if [ $RR -eq 0 ]; then	
		echo "Please change the pi user password (if you have not already)"
		sudo passwd pi
		RU=$?
		if [ $RU -eq 0 ]; then
			touch passchanged
		fi
	fi
fi

sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

sudo apt install -y --no-install-recommends build-essential librtaudio-dev qt5-default autoconf automake libtool make libjack-jackd2-dev qjackctl audacity qt5-qmake qtdeclarative5-dev qttools5-dev-tools git
#(choose Yes in to allow user Realtime privieleges in Jackd)

pushd .
cd ..; git submodule update --init
popd

pushd .
cd ../jacktrip/src/
./build
cd ..
sudo cp builddir/jacktrip /usr/local/bin/
sudo chmod 755 /usr/local/bin/jacktrip

cd ../jamulus
qmake Jamulus.pro
make clean
make
sudo make install
popd


