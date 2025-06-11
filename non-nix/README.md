# Non-nix configs

This directory contains configuration files that I don't want to manage with Nix. The main reason under this is that these files will be usually modified by the running program. For example `zed` might modify its config file when I toggle some options in the UI. If I manage this file with Nix, I will have to rebuild the whole system to apply the changes.
