class Ceres < Formula
  desc "CenterDevice SRE (ceres)"
  homepage "https://github.com/lukaspustina/ceres"
  head "https://github.com/lukaspustina/ceres.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/ceres completions --shell bash > #{completion_dir}/ceres.bash-completion"
    system "sh", "-c", "./target/release/ceres completions --shell fish > #{completion_dir}/ceres.fish"
    system "sh", "-c", "./target/release/ceres completions --shell zsh  > #{completion_dir}/_ceres"

    bash_completion.install "#{completion_dir}/ceres.bash-completion"
    fish_completion.install "#{completion_dir}/ceres.fish"
    zsh_completion.install "#{completion_dir}/_ceres"

    bin.install "target/release/ceres"
    man1.install "docs/man1/ceres.1"
    man5.install "docs/man5/ceres.conf.5"
  end

  test do
    system "#{bin}/ceres", "--help"
  end
end
