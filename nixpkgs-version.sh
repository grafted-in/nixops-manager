#!/usr/bin/env bash
export nixpkgs_channel="https://nixos.org/channels/nixpkgs-unstable"
export nixpkgs_snapshot="https://d3g5gsiof5omrk.cloudfront.net/nixpkgs/nixpkgs-17.03pre98765.6043569/nixexprs.tar.xz"
export nixops_version="nixops"  # Use the packaged nixops

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
