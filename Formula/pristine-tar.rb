class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      :tag      => "1.48",
      :revision => "b654853935048d2f729c414749520098995ca61c"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    sha256 "3005fb3ca7ff4f09b4236588d6c5a772d58a28ba07f652eb3e69da115e1e4c6f" => :catalina
    sha256 "3c32a38bbf88ee7725fb86604884258183eac7397fb01fadf5f68887b3c0de1e" => :x86_64_linux
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
