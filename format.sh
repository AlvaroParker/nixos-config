#! /usr/bin/env bash
find . -type f -name "*.nix" -print0 | xargs -0 -n1 nixfmt
