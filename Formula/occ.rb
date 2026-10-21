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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.1/occ-0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "1590a81db5a8c15899c4724e1aacbb5d6c74060981fc5f0ad3128c4a7dabe4e0"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.1/occ-0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "963dd11f429dcd0524db3936c174d4adcf77a1a3c2a2f90dcf2c7fdecff70831"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.1/occ-0.7.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ccfeaf4e2542f938bbe7f0ec7958ecea1dd9008e12c71ea7b650a86aa10d8332"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.1/occ-0.7.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "86399a9ea8dce2c0fd6d11ad799dd1601b6cdc61d5e5c02378bbe40285dd40ee"
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
