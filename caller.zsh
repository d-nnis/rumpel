#!/usr/bin/env zsh

ffmpeg_webm() {
  local abspath=${(%):-%x}
  local abspath=$(dirname $abspath)
  echo location of called script: $abspath
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

