#!/usr/bin/env bash

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

nixpkgs_snapshot=$(eval echo "$(nix-instantiate --eval -E "(import \"$here/nixpkgs-version.nix\").url")")
nixpkgs_cache=$(eval echo "$(nix-instantiate --eval -E "(import \"$here/nixpkgs-version.nix\").cache")")
export nixpkgs_snapshot
export nixpkgs_cache
export nixops_version="nixops"

# Or you can use a more recent build of nixops:
#if [ "$(uname)" == "Darwin" ]; then
#  export nixops_version="/nix/store/1gy62jcxjc09n9gk0ns4qk3d9b9kcda7-nixops-1.5pre2121_fc43d9c"
#else
#  export nixops_version="/nix/store/d553achr2pvh6p8838a4shbhjpp5d6s6-nixops-1.5pre2121_fc43d9c"
#fi
#
#if [ ! -d "$nixops_version" ]; then
#  nix-store -r "$nixops_version"
#fi
