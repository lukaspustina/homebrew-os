class Mhost < Formula
  desc "Like `host`, but uses multiple DNS servers massively parallel and compares results"
  homepage "https://github.com/lukaspustina/mhost"
  url "https://github.com/lukaspustina/mhost/archive/0.0.6.tar.gz"
  sha256 "78e25ab99fb881a6d6b39a8e27d3017fd3476842a550e9cb82babb9b9f889c2e"
  head "https://github.com/lukaspustina/mhost.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--features", "bin"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/mhost --completions bash > #{completion_dir}/mhost.bash-completion"
    system "sh", "-c", "./target/release/mhost --completions fish > #{completion_dir}/mhost.fish"
    system "sh", "-c", "./target/release/mhost --completions zsh  > #{completion_dir}/_mhost"

    bash_completion.install "#{completion_dir}/mhost.bash-completion"
    fish_completion.install "#{completion_dir}/mhost.fish"
    zsh_completion.install "#{completion_dir}/_mhost"

    bin.install "target/release/mhost"
    man1.install "docs/man1/mhost.1"
  end

  test do
    system "#{bin}/mhost", "--help"
  end
end
