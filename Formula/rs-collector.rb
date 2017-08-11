class RsCollector < Formula
  desc "An scollector compatible telemetry collector for Galera, JVM, Mongo, Postfix etc."
  homepage "https://github.com/lukaspustina/rs-collector"
  url "https://github.com/lukaspustina/rs-collector/archive/v0.0.9.tar.gz"
  sha256 "98abb3c57d6b2d043e1606e47ce02e678b8b9a2b2bfe81be01d3bdd640ed344f"
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
