#!/usr/bin/env zsh

# calculate no of commits (lines) to display depending on terminal height
function nocommits() {
  theight=$(tput lines)
  nocommits=$(($theight-10))
  echo $nocommits
}

