class Occ < Formula
  desc "Command-line tool and node for Office Cockpit"
  homepage "https://github.com/kairelio-hq/occ-releases"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "e31cdf53577a459662827cc2a2f6ea8784add6c5e05344e90c5bb642c46f5b28"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "9e04b191ec49321d5b32f0b0daa8941ec4d3c2bd17a9e6fe1b80d9d9c86e273c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f6c8934ffa4aaa64ea56d2d63d203aeec6c4265097ef63638160af8169d4062f"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.3.0/occ-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "94a94550f5b6a15d43dee00ccd0287ca1adc5d8ef2a200a7da470f1780318af8"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
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
