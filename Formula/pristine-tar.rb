class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      tag:      "1.48",
      revision: "b654853935048d2f729c414749520098995ca61c"
  license "GPL-2.0"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    rebuild 1
    sha256 "336eccc1a4199061fb32b173b88c09f3f98403106ed63c375ea7a58308a49467" => :catalina
    sha256 "4ba0ea1b8929d06aa56be0fcc1c311604008614900c76e492d9e1df04b92c0b5" => :x86_64_linux
  end

  depends_on "perl" => :build
  depends_on "shunit2" => :build
  depends_on "bzip2"
  depends_on "gnu-tar"
  depends_on "gzip"
  depends_on "pbzip2"
  depends_on "pixz"
  depends_on "xdelta"
  depends_on "xz"

  def install
    system "perl", "Makefile.PL",
        "TAR_PROGRAM=tar", \
        "XDELTA_PROGRAM=xdelta", \
        "ZCAT_PROGRAM=zcat", \
        "PREFIX=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_predicate bin/"pristine-tar", :exist?
  end
end
