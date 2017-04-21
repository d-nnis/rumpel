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
# integrate with gfmS: git submodule foreach git_hide
git_toplevel() {
  echo `git rev-parse --show-toplevel`
}

git_showhidden() {
  # files=() declares files to be an array
  files=($(git ls-files -v | grep "^[[:lower:]]" | sed 's/h //'))
  # alternativ mit awk:
  #files=($(git ls-files -v | grep "^[[:lower:]]" | awk '{print $2}'))
#  for file in $files; do
#    echo $file
#  done
  echo "${files[@]}"
}

git_unhideall() {
  files=($(git_showhidden))
  for file in $files; do
    git update-index --no-assume-unchanged "$file"
    if [ "$?" -gt "0" ]; then
      echo "could not unhide $file"
    else
      echo "unhid $file"
    fi
  done
}

git_hide() {
  gtl=$(git_toplevel)
  echo $gtl
  githide=$(git_toplevel)/.githide

  if [ ! -e $githide ]; then
    echo "no " `basename "$githide"` "file"
    echo "unhide all, if any:"
    git_unhideall
    return 0
  fi

  # splits at every space as well
  #tohide=($(less $githide))
  # splits only at newlines (f)
  tohide=("${(@f)$(less $githide)}")
  
  # element 0 of array is empty
  if [ -z $tohide[1] ]; then
    echo file $githide is empty
    echo exiting
    return 0
  else
    files=($(git_showhidden))
    echo "hidden files before:"
    if [ -z $files[1] ]; then
      echo NONE
    else
      for file in $files; do
        echo $file
      done
    fi
    echo "reset git's update-index"
    # gunhide-all > /dev/null
    git_unhideall
  fi
  rt_err=0
  # TOSORT: zmodload necessary?
  zmodload zsh/pcre
  for gh in $tohide; do
    if [[ "$gh" -pcre-match ^#.* ]]; then
      continue
    fi
    echo hide $gh
    # ghide $gh
    git update-index --assume-unchanged "$gh"
    err=$?
    if [ "$err" -gt "0" ]; then
      echo git return code: $err
      echo "file $gh is probably not part of git's index"
      rt_err=1
    fi
  done
  if [ "$rt_err" -gt "0" ]; then
    echo there was an error
    return 1
  fi
  echo "done, exiting"
  return 0
}

#TODO: mass kill machine à la:
#psaux G firefox | cut -d" " -f5 | xargs sudo kill -9
