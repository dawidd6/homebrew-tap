class Quickemu < Formula
  desc "Quickly create and run optimised desktop virtual machines"
  homepage "https://github.com/quickemu-project/quickemu"
  url "https://github.com/quickemu-project/quickemu/archive/refs/tags/4.3.tar.gz"
  sha256 "a9632e63f821e70071dfd300e84c01fb857cc15088edc085a408d206d7278fec"
  license "MIT"
  head "https://github.com/quickemu-project/quickemu.git", branch: "master"

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
