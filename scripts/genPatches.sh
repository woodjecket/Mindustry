#!/usr/bin/env bash

base=$(git log --grep PATCH-BASE --format=reference | awk '{print $1}')
picked=$(git log --grep PATCH-PICKED --format=reference | awk '{print $1}')
echo "BASE=$base,PICKED=$picked"

rm -rf ../patches/picked/*
git format-patch --full-index --no-signature --zero-commit -N --ignore-blank-lines -o ../patches/picked "$base...$picked^"
rm -rf ../patches/client/*
git format-patch --full-index --no-signature --zero-commit -N --ignore-blank-lines -o ../patches/client "$picked"
(cd .. && git add patches)