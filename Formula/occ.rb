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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.0/occ-0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "4db58fa25f4778a0bc03c6791b9b1231716d33eeed3c9ec72746dd0749f56a83"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.0/occ-0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "7649892af9f6ddf37b2f2cc8d263d7505ad027b1cf3f39303cdb0e5f1fd7da55"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.0/occ-0.9.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1dbc818468b0e528a23245d2523c4eb71eb32858911b2b284bd3dbc6a271bd63"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.0/occ-0.9.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c5801278ba2cb07127bcaa1c74a1a712f5ada279cec182da07b13503a9cdd54c"
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
