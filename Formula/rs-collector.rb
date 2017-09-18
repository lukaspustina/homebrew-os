class RsCollector < Formula
  desc "An scollector compatible telemetry collector for Galera, JVM, Mongo, Postfix etc."
  homepage "https://github.com/lukaspustina/rs-collector"
  url "https://github.com/lukaspustina/rs-collector/archive/v0.1.2.tar.gz"
  sha256 "0116e8a20796446e9259a46205f118e8f02c47a619b8a35415b974d96507216b"
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
