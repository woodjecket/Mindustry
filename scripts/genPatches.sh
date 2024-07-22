#!/usr/bin/env bash

base=$(git log --grep "#PATCH-BASE#" --format=reference | awk '{print $1}')
picked=$(git log --grep "#END-PICKED#" --format=reference | awk '{print $1}')
work=$(git log --grep "#Work-In-Progress#" --format=reference | awk '{print $1}')
echo "BASE=$base,PICKED=$picked,WIP=$work"

rm -rf ../patches/picked/*
git format-patch --full-index --no-signature --zero-commit -N --ignore-blank-lines -o ../patches/picked "$base...$picked^"
rm -rf ../patches/client/*
git format-patch --full-index --no-signature --zero-commit -N --ignore-blank-lines -o ../patches/client "$picked...$work^"
rm -rf ../patches/work/*
git format-patch --full-index --no-signature --zero-commit -N --ignore-blank-lines -o ../patches/work "$work..."
(cd .. && git add patches)