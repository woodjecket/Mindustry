#!/usr/bin/env bash

function getRef() {
    git ls-tree "$1" "$2" | cut -d' ' -f3 | cut -f1
}

base=$(cd .. && getRef HEAD work || exit 1)
git reset --hard "$base"

git commit -m "#PATCH-BASE#" --allow-empty
git am --no-gpg-sign -3 ../patches/picked/*
git commit -m "#END-PICKED#" --allow-empty
git am --no-gpg-sign -3 ../patches/client/*
git commit -m "#Work-In-Progress#" --allow-empty
git am --no-gpg-sign -3 ../patches/work/*

echo "Now at $(git rev-parse HEAD)"