class RsCollector < Formula
  desc "An scollector compatible telemetry collector for Galera, JVM, Mongo, Postfix etc."
  homepage "https://github.com/lukaspustina/rs-collector"
  url "https://github.com/lukaspustina/rs-collector/archive/v0.1.2.tar.gz"
  sha256 "c7d9c70b1f87f0ec0ed8d5d9abd8c8a42293e8de6b654672bcbd37bfaa42694a"
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
