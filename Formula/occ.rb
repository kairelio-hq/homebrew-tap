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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.9/occ-0.9.9-aarch64-apple-darwin.tar.gz"
      sha256 "3825e536961bce729939dd9013d8c58a232dc5190a66a220cf60c19ee913a185"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.9/occ-0.9.9-x86_64-apple-darwin.tar.gz"
      sha256 "beca34e0dbe8e2c1cee8cd337ab2ac8f2c95e30b6f1379268ec82b33d6a5586e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.9/occ-0.9.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "faf62062b63102fd084b4a364403f6dafef9f337d9a7f601388c09434d9a348e"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.9/occ-0.9.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "57a765d7599f698913725c7c5923f81922e5fd56f9afb98968d6c2c4a19253ba"
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
