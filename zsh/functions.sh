#!/usr/bin/env bash

function runAll() {
  ls -d -- */ | xargs -I {} bash -c "cd '{}' && $1"
}

f() {
  fff "$@"
  cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")" || exit
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions

    versions=$(asdf list-all "$lang" | fzf --tac --no-sort --multi)

    if [[ $versions ]]; then
      for version in $versions; do asdf install "$lang" "$version"; done
    fi
  fi
}

commands() {
  CMD=$(
    (
      (alias)
      (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_")
    ) | fzf | cut -d '=' -f1
  )

  eval "$CMD"
}

function getFZFPreviewer() (
  if [[ $(hasBinary bat) = TRUE ]]; then
    echo "bat --style=numbers --color=always --line-range :500 {}"
  else
    echo "cat {}"
  fi
)

sf() {
  $EDITOR "$(fd --no-ignore --type f --exclude '*.{png,jpg}'| fzf --multi --reverse --preview "$(getFZFPreviewer)")"
}

# ────────────────────────────────────────────────────────────

# GIT STUFF

gitnewrepo() { mkdir "$*" && cd "$*" && git init && hub create && touch README.md && echo "# " "$*" >>README.md && git add . && git commit -m "init" && git push -u origin HEAD; }

gwc() {
  git clone --bare "$1" .bare
  echo "gitdir: ./.bare" >.git
  git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
  git fetch
  git for-each-ref --format='%(refname:short)' refs/heads | xargs -n1 -I{} git branch --set-upstream-to=origin/{}
}

gwa() { git worktree add "$*"; }
gwr() { git worktree remove "$*"; }
gwrf() { git worktree remove --force "$*"; }

fbra() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" | fzf-tmux -d $((10 + $(wc -l <<<"$branches"))) +m) &&
    git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" | fzf-tmux -d $((10 + $(wc -l <<<"$branches"))) +m) &&
    git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

open-at-line() {
  nvim "$(rg --line-number --hidden . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print "+"$2" "$1}')"
}

watchgotest() {
  fswatch -e ".*" -i "\\.go$" . | xargs -n1 -I {} sh -c "echo $'\e[1;31m'{}$'\e[0m'; go test -v — bench . — benchmem"
}

xcodeenv() {
  local project=$1
  xcodebuild -project "$project.xcodeproj" -target "$project" -showBuildSettings
}

w() {
  local worktree

  worktree=$(
    git worktree list | fzf \
      --prompt="Switch Worktree: " \
      --height 40% --reverse |
      awk '{print $1}'
  )

  cd "$worktree" || return

}

wremote() {
  git worktree add --checkout "$1" "$2" && cd "$2" || exit
}

wremove() {
  git worktree remove "$1"
}

wlocal() {
  git worktree add -b "$1" "$2"
}

# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# Select a docker image or images to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="$(dirname "$(dirname "${java_path:A}")")"
    export JDK_HOME=${JAVA_HOME}
  fi
}

asdf_shell_java() {
  asdf shell java "$1"
  asdf_update_java_home
}

mitmEnable() {

  # the tail command will skip the first line because it's an informational message
  interfaces="$(networksetup -listallnetworkservices | tail +2)"

  IFS=$'\n' # split on newlines in the for loops

  for interface in $interfaces; do
    echo "Setting proxy on $interface"
    networksetup -setwebproxy "$interface" localhost 8080
    networksetup -setwebproxystate "$interface" on
    networksetup -setsecurewebproxy "$interface" localhost 8080
    networksetup -setsecurewebproxystate "$interface" on
  done

  mitmproxy

  for interface in $interfaces; do
    echo "Disabling proxy on $interface"
    networksetup -setwebproxystate "$interface" off
    networksetup -setsecurewebproxystate "$interface" off
  done
}
