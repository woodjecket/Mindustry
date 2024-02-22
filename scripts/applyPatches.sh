#!/usr/bin/env bash

cd work/ || exit 1
git tag -f base
git am --3way --no-gpg-sign ../patches/*