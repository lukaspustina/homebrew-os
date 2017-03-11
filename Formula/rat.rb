class Rat < Formula
  desc "REST API tool - qeuery various REST APIs comfortabl"
  homepage "https://lukaspustina.github.io/rat/"
  url "https://github.com/lukaspustina/rat/archive/v0.1.0.tar.gz"
  sha256 "5bf4c4e97f1c2c977cb8792e80828595d923a695fd2f17ccaff88ada88fd35b7"
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
