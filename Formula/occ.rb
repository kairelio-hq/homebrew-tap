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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.1/occ-0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "3996fc8e41bf9f7f368acc1adab7e483da8cd46b8d3c1ccca0e4ced131886e1b"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.1/occ-0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "bda855582d58595aad1fa08bb301cdaee7a6107be06764daaa3118c26a93eec5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.1/occ-0.6.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "318da93c0829ce7575eb095be0d4387d5ead864acdbebb822be2bb8210ec35a0"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.1/occ-0.6.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e2f1e211e8fe9365c74c1c3124cd7f69c0bb6b3867f4d1634cc6785bd182223e"
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
