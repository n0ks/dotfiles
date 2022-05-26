#!/usr/bin/env bash

function runAll(){
  ls -d */ | xargs -I {} bash -c "cd '{}' && $1"
}

f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}


# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf install $lang $version; done;
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

    eval $CMD
}

function getFZFPreviewer() (
    if [[ $(hasBinary bat) = TRUE ]]; then
        echo "bat --style=numbers --color=always --line-range :500 {}"
    else
        echo "cat {}"
    fi
)

sf() {
    $EDITOR $(fd --type f | fzf --multi --reverse --preview "$(getFZFPreviewer)")
}

# ────────────────────────────────────────────────────────────

# GIT STUFF

gitnewrepo() { mkdir "$*" && cd "$*" && git init && hub create && touch README.md && echo "# " "$*" >>README.md && git add . && git commit -m "init" && git push -u origin HEAD; }
gwc() { git clone --bare $1 $2 && cd $2 && git worktree add main && cd main; }
gwa() { git worktree add "$*"; }
gwr() { git worktree remove "$*"; }
gwrf() { git worktree remove --force "$*"; }

fbra() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&

  branch=$(echo "$branches" | fzf-tmux -d $(( 10 + $(wc -l <<< "$branches") )) +m) &&

  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&

  branch=$(echo "$branches" | fzf-tmux -d $(( 10 + $(wc -l <<< "$branches") )) +m) &&

  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
