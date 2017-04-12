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

## git hide project (TODO)
git_toplevel() {
  echo `git rev-parse --show-toplevel`
}

git_hidefile() {
  tohide=$1
  echo hide me $tohide !
  if [ -z $tohide ]; then
    echo need one file name
    exit 1
  elif [ ! -e $tohide ]; then
    echo file/ dir $tohide does not exist
    exit 2
  fi
  gtl=`git_toplevel`
  githide=`git_toplevel`/.githide

  if [ ! -e $githide ]; then
    touch $githide
    echo "$tohide" | tee $githide > /dev/null
    echo "done"
    exit 0
  fi
  unset args
  orgIFS=$IFS
  while IFS= read -r line; do
    args+=("$line") 
  done < $githide
  IFS=$orgIFS
  append=1
  echo "we want to hide $tohide this"
  for gh in $args; do
    echo $gh
    if [ "$gh" = "$tohide" ]; then
      echo $tohide is in $githide
      append=0
      break
    fi
  done
  if [ "$append" -eq 1 ]; then
    echo "$tohide" | tee -a $githide > /dev/null
    echo "appended $todhide to $githide"
    echo done
  else
    echo "nothing to append"
  fi
}

