class RsCollector < Formula
  desc "An scollector compatible telemetry collector for Galera, JVM, Mongo, Postfix etc."
  homepage "https://github.com/lukaspustina/rs-collector"
  url "https://github.com/lukaspustina/rs-collector/archive/v0.1.1.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
