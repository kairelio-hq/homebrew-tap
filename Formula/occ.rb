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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.2/occ-0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "845003634f89096ec830c1209da0972eb0559b75198820ad79cd37677dcb8d80"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.2/occ-0.6.2-x86_64-apple-darwin.tar.gz"
      sha256 "21f79e0e1a60260ce9b1e51ecadaca86486dc39d6a5349ba736f9b08a6996739"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.2/occ-0.6.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6794151dbd9e119999646b70f43010b8253b8279cc377106188f6697aca27fb6"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.2/occ-0.6.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8f9f5b477e41df39d838966be3a843adc74ded5ea50cc83728503a3b5e42337a"
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
