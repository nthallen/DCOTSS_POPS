#! /bin/bash
# setup git repos. This is intended to be run on the flight computer
# where a git account has already been defined with homedir in /srv/git.
# It could be expanded to also run on the GSE with a githost argument.
# That would require that the githost was already defined in the local
# user's .ssh/config file.
githost=$1
repos="monarch:/usr/local/src/monarch/git DPOPS:/home/DPOPS/src"

if [ $(id -un) = git ]; then
  # Setup the bare repos if they don't already exist
  for repo in $repos; do
    cd /srv/git
    reponame=${repo%:*}
    if [ -d $reponame ]; then
      echo "Bare git repository for $reponame already exists"
    else
      mkdir $reponame.git
      cd $reponame.git
      git init --bare
    fi
  done
else
  # if githost is defined, it's assumed to be remote
  if [ -z "$githost" ]; then
    sudo -u git $0
    githost=127.0.0.1
  fi
  # Now push into the new repos
  for repo in $repos; do
    reponame=${repo%:*}
    repodir=${repo#*:}
    host=$(hostname)
    cd $repodir
    # check to see if it's already setup
    # Should look like:
    #   $host *git@$githost:/srv/git/$reponame.git (fetch)
    #   $host *git@$githost:/srv/git/$reponame.git (push)
    nmatch=$(git remote -v | grep -P "^$host\tgit@$githost:/srv/git/$reponame.git" | wc -l)
    if [ "$nmatch" = 2 ]; then
      echo "$repodir: Git remote for $host is already defined"
    elif git remote -v | grep -qP "^$host\t"; then
      echo "$repodir: Git remote for $host defined with different URL"
    else
      # So we don't have a $githost remote. What do we have?
      # Assuming 'origin' for the moment
      gitmain=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
      if git remote show origin |
           grep -q "$gitmain merges with remote $gitmain"; then
        # We have a sensible gitmain branch that matches origin
        git remote add $host "git@$githost:/srv/git/$reponame.git"
        git push $host $gitmain
      fi
    fi
  done
fi
