#!/usr/bin/env zsh

abspath=$0:h

ffmpeg_webm() {
  for file in $*; do
    echo $file
    $abspath/ffmpeg_webmmp3.pl $file
  done
}
