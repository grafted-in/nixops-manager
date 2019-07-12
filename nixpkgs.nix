builtins.fetchTarball {
  name = "nixos-unstable-2019-03-08";
  #url = https://github.com/johanot/nixpkgs/archive/b3905f0d224bc5c2da3572f7017f05a27df742cd.tar.gz;
  #sha256 = "05jxiyagfgl7s061vz2xmalrrbaz95ymcxdv89j3s700hicyd8pf";
  url = https://github.com/NixOS/nixpkgs/archive/f7f1a2f54ef2b744a26e37418dd6354bc46aa20a.tar.gz;
  sha256 = "061sissl4kr4bzh7pl9a1vihmvf71k9iw0kblvhgvvp6pl10sv0r";
}

# How to push a cache to arm.nixos.org
# ./manage c export | jq '.[].configsPath' -r | ( read conf ; nix-store -qR $conf | while read line; do echo `nix-store -q --size $line` $line ; done | sort -nr | head -n10 | cut -d' ' -f2 | grep -E 'linux|icu4c|glibc|systemd|glib|coreutils|initrd|util-linux' | cachix push arm )
