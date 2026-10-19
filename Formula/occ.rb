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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "4d7e765bd9a1ace38eddfb4aa2d8d38eafe7eeaebbfb5a9044bc028b60e60680"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "eef0155a6572f7fe5f3b1b7d8010a835e657a2217513edf2a3993919646fbf40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9b4264a30b636cc737deadf9c7f11e03406464f8216306f4a2f91c382c3c5212"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "448e7679e440d91dad054930e55a4589928d31d094fbb48039229086925054ff"
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
