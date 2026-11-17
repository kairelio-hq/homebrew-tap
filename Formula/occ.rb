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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.5/occ-0.9.5-aarch64-apple-darwin.tar.gz"
      sha256 "54d05efb645c5665c02cb735984e761fb95cbacbac2d5dea261ab6e6dfea7cfb"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.5/occ-0.9.5-x86_64-apple-darwin.tar.gz"
      sha256 "f036caa64a3cd79ebd181f8fde4662114c0c3a00fc21ccee48b13dfc47aec318"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.5/occ-0.9.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "35fbe7eba5fb27c6c2128e694b852ba99b702b8f83202408abc865977bb80fc3"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.5/occ-0.9.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f15ce6fca3f75ba2612634f6c90a44dbfb5469c6cf37bb9dd11a03297ef6816a"
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
