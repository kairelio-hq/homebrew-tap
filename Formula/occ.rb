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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.0/occ-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "f9a6d2de07b9df3e6f09fa577399800c4ab08591a6a0da9585d8670fd2e387be"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.0/occ-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "23c2f15b9aaffbe7fb2f035efa949a36fd29f91cc33b2a8d37a8b815bf1a2339"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.0/occ-0.8.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cd2db63a05acea94afd4273310e9eb26bcc2cca6bf3d608640c328627b4f8f59"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.8.0/occ-0.8.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0522de63d5a0817f8a76621416637bea51e84d880a5462b7b4c732eef5d136d7"
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
