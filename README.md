A NixOps Wrapper for Git\* Projects
=================================

\* The dependency on Git is only one line and could easily be removed/replaced for your needs.

This tool is a simple wrapper around [NixOps](http://nixos.org/nixops/). The goal is to make
it easier to use NixOps when you want to share your deployment state between members of a team.

To achieve this, this wrapper gives every deployment as a separate state file which is placed
in the same directory as this script. The files have the `.nixops` extension.

You are expected to keep these files in version control. It's also *highly* recommended that you
use a tool like [git-crypt](https://www.agwa.name/projects/git-crypt/) to keep them encrypted with
this entry in `.gitattributes`:

```
*.nixops   binary filter=git-crypt diff=git-crypt
```

This tool also enforces a per-repository version of Nixpkgs via a `nixpkgs-version.sh` file in the
same directory as the script. This ensures that all users have a consistent version of NixOps and
deploy a consistent set of packages to servers.

Most commands work identically to NixOps. However, instead of specifying deployments with
the `--deployment/-d` flag, you select a deployment in the first argument. In other words, instead
of the normal NixOps usage of

```shell
nixops deploy -d stage --check  # Normal nixops usage.
```

You'd run:

```shell
./manage stage deploy --check   # Manage script usage.
```

This assume there is a file `./stage/stage.nixops` where this state is being stored.

Use `./manage --help` to see normal NixOps help.
Use `./manage {deployment} .shell` to open a Nix shell where the environment is set up to use
`nixops` directly with the same behavior as running `./manage` commands.
