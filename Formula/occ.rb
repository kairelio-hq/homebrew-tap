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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.0/occ-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "59451287fc6b8ccddc34fc9ac2ed5accb69c72825d93802309e1f4e81fba2645"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.0/occ-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "ea6f095d2863776fc132b5a921b42275bcc22d4dd930fde000b7233f1d843776"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.0/occ-0.6.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9b576ab2b6d968cab08415650f028d67e8657198a643ffdf38001b2db8a299d4"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.6.0/occ-0.6.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c944ca26db3e5abbc64204075e110903e2a09cb31dbbed1a3ba62505df574d79"
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
