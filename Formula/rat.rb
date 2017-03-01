class Rat < Formula
  desc "REST API tool - qeuery various REST APIs comfortabl"
  homepage "https://lukaspustina.github.io/rat/"
  url "https://github.com/lukaspustina/rat/archive/v0.0.1.tar.gz"
  sha256 "f68c4a09dda35cef7e9cbe3f310dd410a0629cdc77eccbe15713a17166418c42"
  head "https://github.com/lukaspustina/rat.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/rat"

    # Completion scripts are generated in the crate's build directory, which
    # includes a fingerprint hash. Try to locate it first
    # out_dir = Dir["target/release/build/ripgrep-*/out"].first
    # bash_completion.install "#{out_dir}/rg.bash-completion"
    # fish_completion.install "#{out_dir}/rg.fish"
    # zsh_completion.install "#{out_dir}/_rg"
  end

  test do
    system "#{bin}/rat", "help"
  end
end
