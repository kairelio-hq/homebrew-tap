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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.1/occ-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "bf950519ccf06648a749fe6167306d98df7077506b5423cd7d309f4d9ff5d88a"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.1/occ-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "806191a409430005ed65a94a05e5b59b26e7ecaff2be7d77d39f565dc51d83d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.1/occ-0.5.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cadebec91db373b50157b89103801fc32798506fa4dd600db784bae9260977a7"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.5.1/occ-0.5.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8de91e4fb4af27c8674452964f9dabe4e93be093a07adef6a0b66c47a9fe5605"
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
