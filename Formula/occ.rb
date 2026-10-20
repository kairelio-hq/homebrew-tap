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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.3/occ-0.6.3-aarch64-apple-darwin.tar.gz"
      sha256 "811a45a75946cf15426e08bab304dc075e1ab418d0231de40c678fa7d1764c73"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.3/occ-0.6.3-x86_64-apple-darwin.tar.gz"
      sha256 "1df965c7d3578935c6c5c0349d249a9dcef3a28610e73e0cf7ca9934b2280c9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.3/occ-0.6.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b01da8ff2de2e0a5fa11c25db1e9f23a768d9107122ffbfd6fd0695dc7a82940"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.3/occ-0.6.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4654ae216cbe381a38c5a2388b2581b25e1f6379d5944c9ebd9c1d1c869e6943"
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
