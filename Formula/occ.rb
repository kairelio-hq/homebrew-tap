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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.1/occ-0.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "dda7579732b4d6a768328a8bc46a362070701e5676ab4efc9fc08af92ba27c21"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.1/occ-0.9.1-x86_64-apple-darwin.tar.gz"
      sha256 "3b7c318cdff6429e0a3b8446f062458a15f7b80f6067005a6d29b7f09b9815a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.1/occ-0.9.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "910751a093c813404f7a20175b420a4669e9ca605807abb752187e0596dc557f"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.1/occ-0.9.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d35d59918769fa97ea1dbddfc73016f959af739a8bcf0e5d04923072ef14c744"
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
