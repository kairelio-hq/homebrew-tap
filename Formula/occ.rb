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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.2/occ-0.9.2-aarch64-apple-darwin.tar.gz"
      sha256 "c9fde9c56784ebbbc896312348688c161993ec6a4fac007ef7aa404b3cb1ac8e"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.2/occ-0.9.2-x86_64-apple-darwin.tar.gz"
      sha256 "9f4b9b2bd177e45a1b09ca43a645a2b4c3fd0d3ec605c702776f803763cc3ebc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.2/occ-0.9.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6d792ddb09eca086eb66156e11258e9e213b5753e25f4af2af5c6609f66c0370"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.2/occ-0.9.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c442370024793d7a648ed1a5c96815ba71c594ad9285833546880a88b1391195"
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
