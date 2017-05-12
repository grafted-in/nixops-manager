# Import this instead of <nixpkgs> to get the repo-specific version of nixpkgs.

import ((import <nixpkgs> {}).fetchzip (import ./nixpkgs-version.nix))
