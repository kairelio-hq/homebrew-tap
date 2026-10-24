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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.1/occ-0.8.1-aarch64-apple-darwin.tar.gz"
      sha256 "ba469a9819fbdf1fdbc8116296b4e8d5514eec11d8d357eb3097727187461667"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.1/occ-0.8.1-x86_64-apple-darwin.tar.gz"
      sha256 "36fc007a00939020178143ce6203390b4fed6c8f415bbb9507c18fff518aba86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.1/occ-0.8.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "af6482c72b16084d29712d867138c143f5ab9dbe1f8d6dbd28c84823cf9b1e08"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.1/occ-0.8.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6464f9ccb9af4c78f1e225cfbdcc8cab74f8daa756a550a1ce8300843dc561c1"
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
