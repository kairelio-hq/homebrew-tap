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
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.4.0/occ-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "ccea8fefc3806c670a324834f013f3651d761130f50f1ca738f317f9437a9328"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.4.0/occ-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "bc565f6720a95d9e52f5dd0d2f81b9e29a9e1850f4f919f9a93a731a9afc4552"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.4.0/occ-0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c7804b92f04fc6026572e68a4ca8e7b9ae69fb36a5290aab36a283785e137662"
    end
    on_intel do
      url "https://github.com/kairelio-hq/occ-releases/releases/download/v0.4.0/occ-0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4a829ba7156eff18cc6ecee5e982f370f01574ac481783993796b14de72757f8"
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
