{ writeScriptBin, bash, nix, nodejs, nodePackages, ...}:

writeScriptBin "-nix-project-tool" ''#!${bash}/bin/bash

PATH="${nodePackages.npm}/bin:$PATH"
PATH="${nodePackages.npm2nix}/bin:$PATH"
PATH="${nodejs}/bin:$PATH"
PATH="${nix}/bin:$PATH"
export PATH

case $1 in
  help)
    cat <<EOF
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

EOF
    ;;
  version)
    echo -n "npm version: "; npm --version
    echo -n "node version: "; node --version
    echo -n "npm2nix version: "; npm2nix --version
    ;;
  update-dependencies)
    npm2nix package.json versions.nix
    ;;
  build)
    nix-build
    ;;
  run)
    nix-build
    n=$(find ./result/bin/ -executable -not -type d | wc -l)

    # This could be made configurable instead
    if test $n '==' 1
    then exec $(find ./result/bin/ -executable -not -type d) "$@"
    else echo "Expected exactly one executable in ./result/bin"
         exit 1
    fi
    ;;
  npm)
    exec npm "$@"
    ;;
  node)
    exec node "$@"
    ;;
  npm2nix)
    exec npm2nix "$@"
    ;;
  *)
    exec npm "$@"
    ;;
esac
''
