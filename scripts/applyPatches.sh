#!/usr/bin/env bash

cd work/ || exit 1
git tag -f base
git am --no-gpg-sign ../patches/picked/*
git tag -f picked
git am --no-gpg-sign ../patches/client/*