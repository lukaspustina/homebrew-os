class Luftpost < Formula
  desc "Watches luftdaten.info particulates sensors and sends E-Mails if measurements exceed thresholds"
  homepage "https://lukaspustina.github.io/luftpost/"
  url "https://github.com/lukaspustina/luftpost/archive/v0.0.2.tar.gz"
  sha256 "626ee82a9aa3265c1bdcc5a9aa1a1b59b33fdd3fd1a1d88c16e156e446cd20f9"
  head "https://github.com/lukaspustina/luftpost.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/luftpost --completions bash > #{completion_dir}/luftpost.bash-completion"
    system "sh", "-c", "./target/release/luftpost --completions fish > #{completion_dir}/luftpost.fish"
    system "sh", "-c", "./target/release/luftpost --completions zsh  > #{completion_dir}/_luftpost"

    bash_completion.install "#{completion_dir}/luftpost.bash-completion"
    fish_completion.install "#{completion_dir}/luftpost.fish"
    zsh_completion.install "#{completion_dir}/_luftpost"

    bin.install "target/release/luftpost"
  end

  test do
    system "#{bin}/luftpost", "help"
  end
end
