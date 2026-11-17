class Occ < Formula
  desc "Command-line tool and node for Office Cockpit"
  homepage "https://github.com/kairelio-hq/occ-releases"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.7/occ-0.9.7-aarch64-apple-darwin.tar.gz"
      sha256 "e2abeab3646835aab4b0e54feb6ad0aa4c6f34b7470fe8702344191e75e24725"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.7/occ-0.9.7-x86_64-apple-darwin.tar.gz"
      sha256 "47b1cb6225fb60ed0a43217e4c773b555cc09bf595ff795bbf20e37669cf9d1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.7/occ-0.9.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cb4a2915f2afaf16cd8a2d4e0ad3b06e091f79820946ee75166d016409c7f570"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.7/occ-0.9.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2f521e0d1905f919a4ece15f16ed7da0e663dc97566e05a01a2e40993e3a458a"
    end
  end

  def install
    bin.install "occ"
  end

  def caveats
    <<~EOS
      To make this machine an Office Cockpit node:
        occ register https://cockpit.kairelio.com
      That installs the node as a login service, "Office Cockpit Node" (a LaunchAgent on macOS,
      a systemd --user unit on Linux), run through #{HOMEBREW_PREFIX}/bin/occ so `brew upgrade occ` reaches it
      at its next restart. Manage it with `occ node service install|uninstall|status|logs`.
      Do not also run the node with `brew services`: two nodes for one config exclude each other.
    EOS
  end

  test do
    assert_equal "occ #{version}", shell_output("#{bin}/occ --version").strip
    assert_match "usage:", shell_output("#{bin}/occ help 2>&1", 2)
  end
end
