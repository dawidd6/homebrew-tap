class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      tag:      "1.49",
      revision: "9401d7c09f575173d84727cae58674dbcc20106e"
  license "GPL-2.0"
  revision 2

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/pristine-tar-1.49_2"
    sha256 "b51f5342fbaa80ee2c2c638a3865b160ed4d28f3127909371d6af3ada46c7d5a" => :big_sur
    sha256 "ad5e02423063afb0ee5988fe5a8b2ad8cee78a01098ab0f99fd3fc83cf005e08" => :catalina
    sha256 "dfb48a01412b9ca5982996816c00396c9a7454f84d8b5a111f321b3ed5ddff2f" => :x86_64_linux
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
