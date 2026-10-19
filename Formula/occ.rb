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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.0/occ-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "a8367c631588948def1a072e842d614970d1506c1d99e0863e56f9dba0a4f1dc"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.0/occ-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "9bec8563af22617df42eb9adc56e1a9f829cb149948b2464599820964bd8050b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.0/occ-0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "967e6a49bf1029cef371eea7bc2091c9dd5078d1699b94126cd43cb35bb19739"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.0/occ-0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "351e0cf0e800ad67eaf7c5ed2bad0f724921616d3e756f32a10ae73e2664fa5f"
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
