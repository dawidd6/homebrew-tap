class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      tag:      "1.49",
      revision: "9401d7c09f575173d84727cae58674dbcc20106e"
  license "GPL-2.0"
  revision 3

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/pristine-tar-1.49_3"
    sha256 big_sur:      "caecd51d682616689319f3e303b6d2c0303b230bae714122b933124c72925501"
    sha256 catalina:     "4e24aac47b2b73267372798b0b73b1d5ae347932f837fddf47a2d4a4a50fa84e"
    sha256 x86_64_linux: "0f458a2c2edd1ccdb06cccd3186c3a02237d11d07335ee7ef70f465e2c6b1690"
  end

  depends_on "perl" => :build
  depends_on "shunit2" => :build
  depends_on "bzip2"
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
