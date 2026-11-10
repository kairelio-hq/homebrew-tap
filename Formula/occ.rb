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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.4/occ-0.9.4-aarch64-apple-darwin.tar.gz"
      sha256 "690cf98be03eacfcc819eaf525d52b79b32ebe60b40c5c3bd03fc35b06288ddb"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.4/occ-0.9.4-x86_64-apple-darwin.tar.gz"
      sha256 "8e0fa22d9dcb4d43a2f86806aefe441072f1ef7918f8f9c7b50e352bebf93b75"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.4/occ-0.9.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5ca2f8006da536e33c31bdb16154e382f20f83f47daa9111cee12394fd490126"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.4/occ-0.9.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6f9d326fdda38954a91d53070c0031473a58d6fc7af1ec5664716283ea6437e1"
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
