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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.3/occ-0.7.3-aarch64-apple-darwin.tar.gz"
      sha256 "5db227a75399ae75bcf5eb4c7461e5eb6eef5b670b12161b07135b9512e33ef7"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.3/occ-0.7.3-x86_64-apple-darwin.tar.gz"
      sha256 "b718ac25b4f8ceddc40a0b95091d92dcd65b3d2d9a0c83ff167204651d42e7cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.3/occ-0.7.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7039832cd478179d5bd8b5cc63b53b87bceb34f68851d59bc04ce904c7efdfc3"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.7.3/occ-0.7.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e9788376670c1e31fc598c5e2f8e60d1ffcda9cf68c5e86a7fdf326fb701ce90"
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
