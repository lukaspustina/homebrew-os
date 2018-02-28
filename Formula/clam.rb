class Clam < Formula
  desc "Clam"
  homepage "https://github.com/lukaspustina/clam"
  head "https://github.com/lukaspustina/clam.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/mv_videos"
  end

  test do
    system "#{bin}/mv_videos", "--help"
  end
end
