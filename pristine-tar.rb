# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class PristineTar < Formula
  desc "Regenerate pristine tarballs"
  homepage "http://kitenet.net/~joey/code/pristine-tar"
  url "https://salsa.debian.org/debian/pristine-tar.git",
      :tag => "1.46"

  depends_on "git" => :build
  depends_on "perl" => :build
  depends_on "shunit2" => :build
  depends_on "xdelta"
  depends_on "gnu-tar"
  depends_on "pbzip2"
  depends_on "bzip2"
  depends_on "pixz"
  depends_on "xz"

  def install
    system "perl", "Makefile.PL",
        "TAR_PROGRAM=gnutar", \
        "XDELTA_PROGRAM=xdelta", \
        "ZCAT_PROGRAM=gzcat", \
        "PREFIX=#{prefix}"
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test pristine`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "pristine-tar", "--version"
  end
end
