class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      :tag      => "1.46",
      :revision => "92bd92a9192a6739472e8ee67c293f910f4cd6d1"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    rebuild 1
    sha256 "0636d7309b4e1bed1fd13192c22f5af5f1de04c33ff0b5693ea7681feb66f032" => :mojave
    sha256 "3910ad0bad08b5e816329846e68e245cce6c3fc8332080002eddca75cbf9ff43" => :x86_64_linux
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
