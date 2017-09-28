class Mhost < Formula
  desc "Like `host`, but uses multiple DNS servers massively parallel and compares results"
  homepage "https://lukaspustina.github.io/mhost/"
  url "https://github.com/lukaspustina/mhost/archive/v0.0.1.tar.gz"
  sha256 "2deca77d5f3e3414769ce4eab8b5f9cc56073ae44de7efb52d1645b029f5e969"
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
