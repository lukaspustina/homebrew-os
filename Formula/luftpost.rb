class Luftpost < Formula
  desc "Watches luftdaten.info particulates sensors and sends E-Mails if measurements exceed thresholds"
  homepage "https://lukaspustina.github.io/luftpost/"
  url "https://github.com/lukaspustina/luftpost/archive/v1.0.0.tar.gz"
  sha256 "efa3247f47faa4a8429bebc9b7b9051c3b1711f4b12aa458b4ce1e5fa00dcad0"
  head "https://github.com/lukaspustina/luftpost.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/luftpost -c /dev/null --completions bash > #{completion_dir}/luftpost.bash-completion"
    system "sh", "-c", "./target/release/luftpost -c /dev/null --completions fish > #{completion_dir}/luftpost.fish"
    system "sh", "-c", "./target/release/luftpost -c /dev/null --completions zsh  > #{completion_dir}/_luftpost"

    bash_completion.install "#{completion_dir}/luftpost.bash-completion"
    fish_completion.install "#{completion_dir}/luftpost.fish"
    zsh_completion.install "#{completion_dir}/_luftpost"

    bin.install "target/release/luftpost"
  end

  test do
    system "#{bin}/luftpost", "help"
  end
end
