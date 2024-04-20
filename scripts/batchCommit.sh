#!/usr/bin/env bash

cd work/ || exit 1
git log --pretty=format:"%s%n%an(%ae) in %ad%n" --date=short --output ../.git/TMP_COMMIT_MSG $@
cd ../ && git commit -F .git/TMP_COMMIT_MSG