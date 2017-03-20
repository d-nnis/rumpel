#!/usr/bin/env zsh

abspath=$0:h

ffmpeg_webm() {
  if [ -f $(which ffmpeg) ]; then
    for file in $*; do
      echo $file
      $abspath/ffmpeg_webmmp3.pl $file
    done
  else
    echo cannot find ffmpeg
    exit 1
  fi
}
