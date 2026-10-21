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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.0/occ-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "4e9d95d81efb84b746a354d49b2c656a9d1d5e416643925d85ea5e9b34380aaf"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.0/occ-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "015cba57b3d5ac03f531e4d2015630ed24e5ed6c93d5cb8228249e7fd375c462"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.0/occ-0.7.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "548319b9308e851e7d3c9a6fa64141ef9855dafd6ed5c9570f75e0500842b51a"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.0/occ-0.7.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3f4f1e03dbb10c3695357713b07176d90c60a05df029638f9a92a326de55ccb3"
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
