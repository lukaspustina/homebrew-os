class Mhost < Formula
  desc "Like `host`, but uses multiple DNS servers massively parallel and compares results"
  homepage "https://github.com/lukaspustina/mhost"
  url "https://github.com/lukaspustina/mhost/archive/v0.0.7.tar.gz"
  sha256 "b494cb69dc0b60140a9d50b120b5e388003c046b0f1537234941bc4e6562e100"
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
