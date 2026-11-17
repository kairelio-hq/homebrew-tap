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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.8/occ-0.9.8-aarch64-apple-darwin.tar.gz"
      sha256 "937c79f7a62a2cb1401c487f89632d1bf812452ffb038d19baedea5466a48bdd"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.8/occ-0.9.8-x86_64-apple-darwin.tar.gz"
      sha256 "c0ecfa9a770d35e2b02a9a925782f014ef94fa83ddd1e60bc3aec1cd8efbb53d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.8/occ-0.9.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a7f2be78b6e9716a3cd180a4f91060946191a45ef8f5ade711ed3f25901d2603"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.8/occ-0.9.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5ed4fd6218f3b569d7254c0686ed6168d83d255cb3491dcbb0aabdc5678206e7"
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
