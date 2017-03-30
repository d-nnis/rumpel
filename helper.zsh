#!/usr/bin/env zsh

# calculate no of commits (lines) to display depending on terminal height
function nocommits() {
  theight=$(tput lines)
  nocommits=$(($theight-10))
  echo $nocommits
}

mkcd() {
    if [[ $1 == -* ]]; then
        mkdir -p $1 $2
        cd $2
    else
        mkdir -p $1
        cd $1
    fi
}

hardcopy() {
  prog=$(shift $@)
  if [ -z $prog ]; then
    echo give an installed program as first argument
    exit 1
  fi
  echo $prog
  echo $@
  exit 1
  man -t $prog | lpr $@
}

# TODO
# tar -czf - * | ssh uta@delle tar -xzf - -C /home/uta/backup_freddy/
copyfast() {
  :
  #tar -czf - * | ssh uta@delle tar -xzf - -C /home/uta/backup_freddy/ 
}

# search dotfiles et al for TODO entries and list them
todoparser() {
  :
}

# which: take a stream of filenames and resolve into full paths
whichpipe() {
  for file in $*; do
    which $file
  done
}

