#!/usr/bin/env bash

function getRef() {
    git ls-tree "$1" "$2" | cut -d' ' -f3 | cut -f1
}

refHEAD=$(getRef HEAD work)

git fetch upstream "$1"
refRemote=$(git rev-parse FETCH_HEAD)

if [ "$refHEAD" != "$refRemote" ]; then
  echo "$refHEAD -> $refRemote"
  git reset --hard FETCH_HEAD || (echo "Fail reset" && exit 1)
  (cd .. && git add --force work && git commit -m "Update $refHEAD -> $refRemote")
  echo "Rebuilding patches"
  ../scripts/applyPatches.sh || exit 1
  ../scripts/genPatches.sh || exit 1
else
  echo "No update, revert to work"
  git reset --hard work
fi