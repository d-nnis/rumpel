#!/usr/bin/env zsh

abspath=$0:h

ffmpeg_webm() {
  for file in $*
  $abspath/ffmpeg_webmmp3.pl $*
}
