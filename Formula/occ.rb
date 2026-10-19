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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "cff71f9696db98ee8de01a09403c9fc4602a85d2f6d11e6ee6ec2db2b9327f43"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "77d6ba6830338cf9252f3cec0abd87ba4e4363c6363635176d87d37140ce84e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3659b40271714f80c4c75ce6bd97ab707df0003d331fbb69da4012d526b6c0f8"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9c5e3ac112eea0239380994d39916380602c61d88359d9ce867d9e873ebc1c82"
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
      a systemd --user unit on Linux), run through #{opt_bin}/occ so `brew upgrade occ` reaches it
      at its next restart. Manage it with `occ node service install|uninstall|status|logs`.
      Do not also run the node with `brew services`: two nodes for one config exclude each other.
    EOS
  end

  test do
    assert_equal "occ #{version}", shell_output("#{bin}/occ --version").strip
    assert_match "usage:", shell_output("#{bin}/occ help 2>&1", 2)
  end
end
