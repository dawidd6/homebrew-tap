class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      tag:      "1.49",
      revision: "9401d7c09f575173d84727cae58674dbcc20106e"
  license "GPL-2.0"
  revision 1

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/pristine-tar-1.49_1"
    sha256 "069c067410be7a3363620de8adc7126ad5585d05ec87bb39ef4b40e5c798b31e" => :catalina
    sha256 "1316c42d0fee5e9bcd477c9c186cabdde1f22b44b1d2e9e2da6a81cb686ce01c" => :x86_64_linux
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
