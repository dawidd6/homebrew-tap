class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "https://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      :tag      => "1.47",
      :revision => "aa871f54785b6bc7d161bc369347259c04c73955"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar "/home/linuxbrew/.linuxbrew/Cellar"
    sha256 "5834dc8ab843589e388e5ae2d4ebb83884d85af4a5ffe7b6bfcaab5191f385f9" => :catalina
    sha256 "94288f478b47c1763fb88d6d9c14d8ec611a7e1f774c0159bfd9b2557b328f7f" => :x86_64_linux
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
