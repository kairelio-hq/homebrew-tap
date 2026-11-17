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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.6/occ-0.9.6-aarch64-apple-darwin.tar.gz"
      sha256 "cf068c9768a38595fb8eb780d9ea1767ae9aabc44147e9bfae8dfadddc2af562"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.6/occ-0.9.6-x86_64-apple-darwin.tar.gz"
      sha256 "d953892ae1767498cf58f597cdd065c1ca9fe3b9bc9cfc8b3d4d436651a117c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.6/occ-0.9.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b9064ae1dc371b4d076d12b4639091b61c16fd5993a7421ea6ab8ebbb31d0848"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.6/occ-0.9.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "44226beed8f1bbf8c3453a32152db4e351dc20da9e6141b7f22931185b6ae134"
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
