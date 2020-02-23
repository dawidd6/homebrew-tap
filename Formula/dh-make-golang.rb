class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    :tag     => "v0.3.1",
    :revision => "88748fec2f55c9d34f3d2a6ea9225ce00769b586"
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "65e429705317e1829e7752118b141146b707a0683edf625ff5b14e43dc8e66bc" => :catalina
    sha256 "b097570f503658e3a090fbb0fad4c5948928a766d2d4993c154f4ac04473e1cd" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
