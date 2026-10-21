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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.2/occ-0.7.2-aarch64-apple-darwin.tar.gz"
      sha256 "1c3778a9eb4b0894e9c7accb0990224d9d79b4d41805ce2ad6db324964a48d0d"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.2/occ-0.7.2-x86_64-apple-darwin.tar.gz"
      sha256 "bf526460b0c09b75c95f955149bcbf0efaa75ef8b0ab077df90db1a5e07a7920"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.2/occ-0.7.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "59f3996aee58ed51df3d3c255573543ddc78e0470f449588025baf97875f08d4"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.2/occ-0.7.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dad10e362b887625862b96b13764321a38f134b5156ea23549eb7772761a2325"
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
