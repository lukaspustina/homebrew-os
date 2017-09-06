class RsCollector < Formula
  desc "An scollector compatible telemetry collector for Galera, JVM, Mongo, Postfix etc."
  homepage "https://github.com/lukaspustina/rs-collector"
  url "https://github.com/lukaspustina/rs-collector/archive/v0.1.1.tar.gz"
  sha256 "a0a5693037b7725a92398acb3658ac028b2e64af5d2d0e5f4f3a6dc3f4b1457c"
  head "https://github.com/lukaspustina/rs-collector.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"

    bin.install "target/release/rs-collector"
  end

  test do
    system "#{bin}/rs-collector", "help"
  end
end
