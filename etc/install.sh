#! /bin/bash
echo Running $0
cd $(dirname $0)

function ok_to_do {
  prompt=$1
  echo -n "$1 "
  rv=1
  read resp

  case "$resp" in
    [yY]*) rv=0;;
  esac

  return $rv
}

sources=$(find . -mindepth 2 -type f)
for source in $sources; do
  dest=/etc/${source#./}
  if [ -f "$dest" ]; then
    echo
    # echo "Comparing current $dest to new $source"
    if cmp -s $source $dest; then
      echo $dest is unchanged
    else
      echo "$source has changes:"
      echo
      echo "diff $dest $source"
      diff $dest $source
      echo
      if ok_to_do "OK to replace $dest?"; then
        echo Installing $dest
        sudo cp $source $dest
      else
        echo Skipping replacement of $dest
      fi
    fi
  else
    echo
    if ok_to_do "OK to install new file $dest?"; then
      echo Installing $dest:
      sudo cp $source $dest
    else
      echo Skipping install of $dest
    fi
  fi
done
