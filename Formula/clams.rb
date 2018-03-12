class Clams < Formula
  desc "Clam Binaries"
  homepage "https://github.com/lukaspustina/clams-bin"
  head "https://github.com/lukaspustina/clams-bin.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/mv_videos"
  end

  test do
    system "#{bin}/mv_videos", "--help"
  end
end
