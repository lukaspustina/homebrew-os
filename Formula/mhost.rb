class Mhost < Formula
  desc "Like `host`, but uses multiple DNS servers massively parallel and compares results"
  homepage "https://lukaspustina.github.io/mhost/"
  url "https://github.com/lukaspustina/mhost/archive/v0.0.1.tar.gz"
  sha256 "06a43c0c1439637a410c146d6f6b0e4a656c205ac0c80bef04245262d9ab5e6a"
  head "https://github.com/lukaspustina/mhost.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--features", "bin"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/mhost -c /dev/null --completions bash > #{completion_dir}/mhost.bash-completion"
    system "sh", "-c", "./target/release/mhost -c /dev/null --completions fish > #{completion_dir}/mhost.fish"
    system "sh", "-c", "./target/release/mhost -c /dev/null --completions zsh  > #{completion_dir}/_mhost"

    bash_completion.install "#{completion_dir}/mhost.bash-completion"
    fish_completion.install "#{completion_dir}/mhost.fish"
    zsh_completion.install "#{completion_dir}/_mhost"

    bin.install "target/release/mhost"
  end

  test do
    system "#{bin}/mhost", "help"
  end
end
