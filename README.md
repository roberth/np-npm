
# Sample `npm2nix` integration for `np`

The uniform np interface for node development, proof of concept.

Currently only supports simple command line apps in node + npm.

```
Usage:
  np COMMAND

Commands:
  version
    Prints tool versions

  update-dependencies
    Creates versions.nix, which pins the versions that will be used

  build
    Build the project

  run
    Build the project and run it

  The following commands delegate to the tools of the same name:

  npm2nix
  node
  npm
```
