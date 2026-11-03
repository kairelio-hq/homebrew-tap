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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.3/occ-0.9.3-aarch64-apple-darwin.tar.gz"
      sha256 "17bfca18be85393260e3bbb0ec3857f5e5980a70546aa2b30d395f38a538b483"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.3/occ-0.9.3-x86_64-apple-darwin.tar.gz"
      sha256 "a146f6e1ebf3b2232c3bde8421f3c93efbe3784abdb76c5cc1e3a29f65c6f71f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.3/occ-0.9.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1d131b7096434c7358867bf1318ebec90c938ba90343be9cd2e1b49f83491501"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.9.3/occ-0.9.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5240846d6dec6c783a10797373adb6b47b5b14120b42a466394ab1e4265cbde7"
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
