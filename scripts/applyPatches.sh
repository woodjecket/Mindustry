#!/usr/bin/env bash

git tag -f base
git commit -m PATCH-BASE --allow-empty
git am --no-gpg-sign -3 ../patches/picked/*
git commit -m PATCH-PICKED --allow-empty
git am --no-gpg-sign -3 ../patches/client/*