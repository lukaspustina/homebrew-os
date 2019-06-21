class Ceres < Formula
  desc "CenterDevice SRE (ceres)"
  homepage "https://github.com/lukaspustina/ceres"
  url "https://github.com/lukaspustina/ceres/archive/v0.0.27.tar.gz"
  sha256 "7b9b16284a95e1ec9291c05433009b49c06b7da4ee24252eeabc0c56c70532bc"
  head "https://github.com/lukaspustina/ceres.git"

  def install
    # "#{ENV.fetch("CURL_HOME", ".")}/.cargo" is a little trick to get the users home dir instead of brew temp home dir
    cargo_home = Pathname.new("#{ENV.fetch("CURL_HOME", ".")}/.cargo" || ENV["CARGO_HOME"])
    unless cargo_home.exist?
      odie "Could not find 'cargo' installation neither in CARGO_HOME='#{ENV["CARGO_HOME"]}' nor in HOME='#{ENV.fetch("CURL_HOME", ".")}/.cargo'. Please install using 'rustup' via https://rustup.rs."
    end
    cargo_path = (cargo_home/"bin").to_s
    ENV.prepend_path "PATH", cargo_path

    unless which("rustup", cargo_path)
      odie "Installation method requires 'rustup'. Please install using 'rustup' via https://rustup.rs."
    end

    system "rustup", "override", "set", "stable"
    system "cargo", "build", "--release"

    completion_dir = "#{buildpath}/target/release"
    system "sh", "-c", "./target/release/ceres completions --shell bash > #{completion_dir}/ceres.bash-completion"
    system "sh", "-c", "./target/release/ceres completions --shell fish > #{completion_dir}/ceres.fish"
    system "sh", "-c", "./target/release/ceres completions --shell zsh  > #{completion_dir}/_ceres"

    bash_completion.install "#{completion_dir}/ceres.bash-completion"
    fish_completion.install "#{completion_dir}/ceres.fish"
    zsh_completion.install "#{completion_dir}/_ceres"

    bin.install "target/release/ceres"
    bin.install "contrib/cssh"
    man1.install "docs/man1/ceres.1"
    man5.install "docs/man5/ceres.conf.5"
  end

  test do
    system "#{bin}/ceres", "--help"
  end
end
