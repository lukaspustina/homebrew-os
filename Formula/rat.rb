class Rat < Formula
  desc "REST API tool - qeuery various REST APIs comfortabl"
  homepage "https://github.com/lukaspustina/luftpost"
  url "https://github.com/lukaspustina/rat/archive/v0.4.11.tar.gz"
  sha256 "fb2d74e38f38ebf35fac6f647962c80bd590e76e9f48b2ac391ec16b8d942569"
  head "https://github.com/lukaspustina/rat.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/rat --completions bash > #{completion_dir}/rat.bash-completion"
    system "sh", "-c", "./target/release/rat --completions fish > #{completion_dir}/rat.fish"
    system "sh", "-c", "./target/release/rat --completions zsh  > #{completion_dir}/_rat"

    bash_completion.install "#{completion_dir}/rat.bash-completion"
    fish_completion.install "#{completion_dir}/rat.fish"
    zsh_completion.install "#{completion_dir}/_rat"

    bin.install "target/release/rat"
  end

  test do
    system "#{bin}/rat", "help"
  end
end
