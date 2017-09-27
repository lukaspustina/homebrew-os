class Mhost < Formula
  desc "Like `host`, but uses multiple DNS servers massively parallel and compares results"
  homepage "https://lukaspustina.github.io/mhost/"
  url "https://github.com/lukaspustina/mhost/archive/v0.0.1.tar.gz"
  sha256 "06a43c0c1439637a410c146d6f6b0e4a656c205ac0c80bef04245262d9ab5e6a"
  head "https://github.com/lukaspustina/mhost.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/mhost"
  end

  test do
    system "#{bin}/mhost", "help"
  end
end
