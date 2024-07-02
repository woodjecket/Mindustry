#!/usr/bin/env bash

git tag -f base
git am --no-gpg-sign ../patches/picked/*
git tag -f picked
git am --no-gpg-sign ../patches/client/*