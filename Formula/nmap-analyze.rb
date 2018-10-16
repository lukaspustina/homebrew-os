class NmapAnalyze < Formula
  desc "Analyzes nmap xml output and compares results with expected specification"
  homepage "https://github.com/lukaspustina/nmap-analyze"
  url "https://github.com/lukaspustina/nmap-analyze/archive/v0.3.0.tar.gz"
  sha256 "178f605b87df7c1f8a37c44470c37a82a8be83bdbaa5c6528235544c75b395f4"
  head "https://github.com/lukaspustina/nmap-analyze.git"

  def install
    # "#{ENV.fetch("CURL_HOME", ".")}/.cargo" is a little trick to get the users home dir instead of brew temp home dir
    cargo_home = Pathname.new(ENV["CARGO_HOME"] || "#{ENV.fetch("CURL_HOME", ".")}/.cargo")
    unless cargo_home.exist?
      odie "Could not find 'cargo' installation neither in CARGO_HOME='#{ENV["CARGO_HOME"]}' nor in HOME='#{ENV.fetch("CURL_HOME", ".")}/.cargo'. Please install using 'rustup' via https://rustup.rs."
    end
    cargo_path = (cargo_home/"bin").to_s
    ENV.prepend_path "PATH", cargo_path

    unless which("rustup", cargo_path)
      odie "Installation method requires 'rustup'. Please install using 'rustup' via https://rustup.rs."
    end

    system "rustup", "override", "set", "stable"
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"

    bin.install "target/release/nmap-analyze"
  end

  test do
    system "#{bin}/nmap-analyze", "--help"
  end
end
