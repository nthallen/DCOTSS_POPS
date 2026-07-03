#! /bin/bash
# setup git repos. This is intended to be run on the flight computer
# where a git account has already been defined with homedir in /srv/git.
# It could be expanded to also run on the GSE with a githost argument.
# That would require that the githost was already defined in the local
# user's .ssh/config file.
repos="$*"
[ -z "$repos" ] &&
  repos="monarch:/usr/local/src/monarch/git DPOPS:/home/DPOPS/src"

function nl_error {
  echo "setup_git_repos: $*" >&2
  exit 1
}

function parse_repo {
  # Splits arg into reponame, repodir and gitmain
  repo=$1
  [ -n "$repo" ] || nl_error "Previous error"
  reponame=${repo%%:*}
  repodir=${repo#*:}
  gitmain=${repodir#*:}
  repodir=${repodir%:*}
  [ -d "$repodir" ] || nl_error "repo dir '$repodir' not found"
  [ "$gitmain" = "$repodir" ] && gitmain=''
}

function check_repo {
  parse_repo $1
  host=$(hostname)
  cd $repodir
  # check to see if it's already setup
  # Should look like:
  #   $host *git@$githost:/srv/git/$reponame.git (fetch)
  #   $host *git@$githost:/srv/git/$reponame.git (push)
  nmatch=$(git remote -v |
    grep -P "^$host\tgit@$githost:/srv/git/$reponame.git" | wc -l)
  if [ "$nmatch" = 2 ]; then
    nl_error "$repodir: Git remote for $host is already defined"
  elif git remote -v | grep -qP "^$host\t"; then
    nl_error "$repodir: Git remote for $host defined with different URL"
  else
    # Look at the existing remote to determine main branch
    origin_a=$(git remote | head -n1)
    gitmain=$(git remote show $origin_a | sed -n '/HEAD branch/s/.*: //p')
    if git remote show $origin_a |
         grep -q "$gitmain merges with remote $gitmain"; then
      # We have a sensible gitmain branch that matches origin
      echo "$reponame:$repodir:$gitmain"
    else
      nl_error "Had trouble determining the primary branch for $reponame"
    fi
  fi
}

if [ $(id -un) = git ]; then
  # Setup the bare repos if they don't already exist
  for repo in $repos; do
    cd /srv/git
    parse_repo $repo
    [ -n "$gitmain" ] ||
      nl_error "As git, expected 3-component repo, got '$repo'"
    if [ -d $reponame.git ]; then
      nl_error "Bare git repository for $reponame already exists"
    else
      mkdir $reponame.git
      cd $reponame.git
      git init --bare --initial-branch=$gitmain
    fi
  done
else
  # if githost is defined, it's assumed to be remote
  if [ -z "$githost" ]; then
    for repo in $repos; do
      g_repos="$g_repos $(check_repo $repo)"
    done
    sudo -u git $0 $g_repos
    githost=127.0.0.1
  fi
  # Now push into the new repos
  for repo in $repos; do
    repo=$(check_repo $repo)
    parse_repo $repo
    host=$(hostname)
    cd $repodir
    if [ -n "$gitmain" ]; then
      git remote add $host "git@$githost:/srv/git/$reponame.git"
      git push $host $gitmain
    fi
  done
fi
