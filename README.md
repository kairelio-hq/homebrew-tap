# kairelio-hq/homebrew-tap

Homebrew formulae for Kairelio tools. macOS and Linux (arm64 and x86-64).

## occ

`occ` is the command line and the node of [Office Cockpit](https://cockpit.kairelio.com). Homebrew is the
only supported way to install it. Binaries come from
[kairelio-hq/occ-releases](https://github.com/kairelio-hq/occ-releases) (proprietary, free to use; the
source is private).

Install:

    brew install kairelio-hq/tap/occ
    occ --version

Upgrade:

    brew update && brew upgrade occ

A running node service ("Office Cockpit Node") runs `$(brew --prefix)/bin/occ`, so it picks up the upgrade
at its next restart (`occ node service install` restarts it now).

Uninstall:

    occ node service uninstall      # if this machine runs the node
    brew uninstall occ
    brew untap kairelio-hq/tap

Make this machine a node: `occ register https://cockpit.kairelio.com` (installs the "Office Cockpit Node"
login service; manage it with `occ node service install|uninstall|status|logs`). Do not also use
`brew services` for it.
