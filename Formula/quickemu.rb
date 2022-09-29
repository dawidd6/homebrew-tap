class Quickemu < Formula
  desc "Quickly create and run optimised desktop virtual machines"
  homepage "https://github.com/quickemu-project/quickemu"
  url "https://github.com/quickemu-project/quickemu/archive/refs/tags/4.3.tar.gz"
  sha256 "a9632e63f821e70071dfd300e84c01fb857cc15088edc085a408d206d7278fec"
  license "MIT"
  head "https://github.com/quickemu-project/quickemu.git", branch: "master"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/quickemu-4.3"
    sha256 cellar: :any_skip_relocation, monterey:     "1d72f793b84d9533ea1119e66df6b8438cc63b6fa07bc09f5a8c53f97c16d0c8"
    sha256 cellar: :any_skip_relocation, big_sur:      "7acfc23719ab285f55928dfb4706c33e996e45de347ecea964d9fb08fe658eb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad3b6c71a3fa6c795a70fdff722458b7eda15048e37434df7700cdfda266766d"
  end

  depends_on "bash"
  depends_on "qemu"

  def install
    bin.install "quickget"
    bin.install "quickemu"
    man1.install "docs/quickget.1"
    man1.install "docs/quickemu.1"
    man1.install "docs/quickemu_conf.1"
  end

  test do
    system bin/"quickget", "list"
    system bin/"quickemu", "--version"
  end
end
