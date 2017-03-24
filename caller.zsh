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

gpSOG() {
  $abspath/git_submodule_path.pl | $abspath/git_has_gitspace.pl | $abspath/git_gpOG.pl
}

