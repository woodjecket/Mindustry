#!/usr/bin/env bash

(cd ..&&rm -rf patches/*)
git format-patch --full-index --no-signature --zero-commit -N -o ../patches/picked base...picked
git format-patch --full-index --no-signature --zero-commit -N -o ../patches/client picked
(cd .. && git add patches)