# Tidy Tank for Homebrew

```sh
brew install --cask yuwashme/tidytank/tidy-tank
```

Installs the Mac app (signed and notarized, Apple silicon, macOS 14 or later) and the
`tidytank` command:

```sh
tidytank --dry-run     # see what would come back, delete nothing
tidytank               # guided clean, asks before anything is removed
```

Update with `brew upgrade --cask tidy-tank`, remove with `brew uninstall --cask tidy-tank`.

More at [tidytank.app](https://tidytank.app/).

## Releasing a new version

1. Upload `TidyTank-<version>-macos-signed.dmg` to `dl.tidytank.app` under a new file name.
2. In `Casks/tidy-tank.rb` set `version` and `sha256` (`shasum -a 256 <dmg>`).
3. `brew audit --cask --strict --online yuwashme/tidytank/tidy-tank`, then commit and push.
