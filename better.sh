#!/bin/bash
# Written by Phos, released into the public domain
# Attribution requested. :)
#
# Usage:
# ./better.sh FLAC_FOLDER NAME_PREFIX OUTPUT_PATH
# ./better.sh path/to/My.Awesome.Music.FLAC/ "John Doe - This is an Album" path/to/rtorrent/downloads

convert () {
  artist=$(metaflac --show-tag=ARTIST "$1" | sed 's .......  ')
  album=$(metaflac --show-tag=ALBUM "$1" | sed 's ......  ')
  title=$(metaflac --show-tag=TITLE "$1" | sed 's ......  ')
  date=$(metaflac --show-tag=DATE "$1" | sed 's .....  ')
  number=$(metaflac --show-tag=TRACKNUMBER "$1" |sed 's ............  ')

  flac -cd "$1" 2> /dev/null | lame "$3" -h --tt "$title" --ta "$artist" --tl "$album" --ty "$date" --tn "$number" - "$2" 2> /dev/null;
}

convertv0 () {
  convert "$1" "$2" "-V 0"
}

convertv2 () {
  convert "$1" "$2" "-V 2"
}

convert320 () {
  convert "$1" "$2" "-b 320"
}

FLAC_FOLDER="$1"
NAME_PREFIX="$2"
OUTPUT_PATH="$3"

V0PATH="$OUTPUT_PATH/$NAME_PREFIX [v0]"
V2PATH="$OUTPUT_PATH/$NAME_PREFIX [v2]"
M320PATH="$OUTPUT_PATH/$NAME_PREFIX [320]"

mkdir -p "$V0PATH" "$V2PATH" "$M320PATH"

for flac_file in "$FLAC_FOLDER/"*.flac; do
  emptyname=$(basename "$flac_file" .flac)
  name="$emptyname".mp3

  echo "Converting $emptyname to v0, v2, 320..."
  convertv0 "$flac_file" "$V0PATH/$name" &
  convertv2 "$flac_file" "$V2PATH/$name" &
  convert320 "$flac_file" "$M320PATH/$name" &
  wait
done