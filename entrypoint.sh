#!/bin/bash

git clone https://github.com/limepepper/ansible-role-raspberrypi
cd ansible-role-raspberrypi/files
wget -q https://downloads.raspberrypi.org/raspbian_lite_latest --show-progress
unzip raspbian_lite_latest
BASE=`ls -1 | grep *.img | awk -F'.' '{print $1}'`
sed -i "s/BASE=2018-10-09-raspbian-stretch-lite/BASE=$BASE/g" create-factory-reset
sed -i "s/P2_NEWSIZE_BYTES=2147483648/P2_NEWSIZE_BYTES=4294967296/g" create-factory-reset
sed -i "s/^# P2_SECTORS/ P2_SECTORS/g" create-factory-reset
sed -i "s/^P2_SECTORS/#P2_SECTORS/g" create-factory-reset
for i in `losetup -a -v | awk '{print $1}' | sed 's/://g'`; do losetup -d $i; done
if bash ./create-factory-reset; then
	cp $BASE.restore.img /restore/
else
	echo "Create Factory Reset script failed, please try again"
fi
