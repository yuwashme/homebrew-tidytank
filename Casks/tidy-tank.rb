cask "tidy-tank" do
  version "0.7.2"
  sha256 "c28a5dcf1c2385bc98eb86db03a62c9a331c3cf6e8ad54272a38e5b3f3a0423d"

  url "https://dl.tidytank.app/TidyTank-#{version}-macos-signed.dmg"
  name "Tidy Tank"
  desc "Guided disk cleanup that shows what is safe to delete"
  homepage "https://tidytank.app/"

  livecheck do
    url "https://tidytank.app/checksums.txt"
    regex(/TidyTank[._-]v?(\d+(?:\.\d+)+)[._-]macos[._-]signed\.dmg/i)
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Tidy Tank UI.app"
  # The app carries the command-line tool too. A wrapper (not a plain symlink),
  # because the bundled launcher finds its engine next to itself.
  shimscript = "#{staged_path}/tidytank.wrapper.sh"
  binary shimscript, target: "tidytank"

  preflight_steps do
    write_file "tidytank.wrapper.sh", <<~EOS, base: :staged_path
      #!/bin/sh
      for app in "/Applications/Tidy Tank UI.app" "$HOME/Applications/Tidy Tank UI.app"; do
        if [ -x "$app/Contents/Resources/tidytank" ]; then
          exec "$app/Contents/Resources/tidytank" "$@"
        fi
      done
      echo "tidytank: Tidy Tank UI.app not found in /Applications or ~/Applications" >&2
      exit 1
    EOS
    set_permissions "tidytank.wrapper.sh", "0755", base: :staged_path
  end

  # Your unlock code in ~/.config/tidytank is kept on purpose.
  zap trash: [
    "~/Library/Caches/tidytank",
    "~/Library/Logs/TidyTank",
    "~/Library/Preferences/app.tidytank.TidyTank.preview.plist",
  ]
end
