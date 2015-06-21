#!/usr/bin/env bash
# Written by Nikolai Vazquez
# Solution for removing drive folders left behind after unmount with ntfs-3g in OS X
# Usage ./ntfsfix.sh [list of volumes]

if [ $# -eq 0 ]; then
	declare -a points=("share" "Windows 8.1")
else
	points="$@"
fi

for point in "${points[@]}"; do
	if mount | grep "on $point" > /dev/null; then
		echo "All is good, nothing to see here. \"$point\" is mounted Move along."
	else
		if diskutil list | grep "$point" > /dev/null; then
			diskutil unmount "$point" && sudo find /Volumes -maxdepth 1 -name "$point*" -exec rm -rf {} \;
		else
			echo "\"$point\" is not a valid volume"
		fi
	fi
done
