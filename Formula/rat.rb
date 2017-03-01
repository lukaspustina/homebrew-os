class Rat < Formula
  desc "REST API tool - qeuery various REST APIs comfortabl"
  homepage "https://lukaspustina.github.io/rat/"
  url "https://github.com/lukaspustina/rat/archive/v0.0.1.tar.gz"
  sha256 "f68c4a09dda35cef7e9cbe3f310dd410a0629cdc77eccbe15713a17166418c42"
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
