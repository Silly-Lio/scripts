#!/bin/bash
#
# This script offers provides the ability to update the
# Legacy Boot payload, set boot options, and install
# a custom coreboot firmware for supported
# ChromeOS devices
#
# Created by Mr.Chromebox <mrchromebox@gmail.com>
#
# May be freely distributed and modified as needed,
# as long as proper attribution is given.
#

#where the stuff is
#script_url="https://raw.githubusercontent.com/Silly-Lio/scripts/master/"
script_url="https://raw.githubusercontent.com/Silly-Lio/scripts/master/"

#ensure output of system tools in en-us for parsing
export LC_ALL=C

#set working dir
if cat /etc/lsb-release | grep "Chrom" > /dev/null 2>&1; then
	# needed for ChromeOS/ChromiumOS v82+
	mkdir -p /usr/local
	cd /usr/local
else
	cd /tmp
fi

#get support scripts
echo -e "\nDownloading supporting files..."
rm -rf firmware.sh >/dev/null 2>&1
rm -rf functions.sh >/dev/null 2>&1
rm -rf sources.sh >/dev/null 2>&1
curl -LO ${script_url}firmware.sh
rc0=$?
curl -LO ${script_url}functions.sh
rc1=$?
curl -LO ${script_url}sources.sh
rc2=$?

if [ $rc0 -ne 0 ]; then
	echo -e "Error firmware downloading one or more required files; cannot continue"
	exit 1
fi

if [ $rc1 -ne 0 ]; then
	echo -e "Error functions downloading one or more required files; cannot continue"
	exit 1
fi

if [ $rc2 -ne 0 ]; then
	echo -e "Error sources downloading one or more required files; cannot continue"
	exit 1
fi


source ./sources.sh
source ./firmware.sh
source ./functions.sh

#set working dir
cd /tmp

#do setup stuff
prelim_setup
[[ $? -ne 0 ]] && exit 1

#show menu
menu_fwupdate
