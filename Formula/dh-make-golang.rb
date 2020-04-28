class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    :tag      => "v0.3.3",
    :revision => "c43abd765cf51c06bbcaa5479dc49aab1396989f"
  revision 1
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "d428934ceb047b30a1807997f94f5494befbedf8940839d0d188918c790049da" => :catalina
    sha256 "d360f1576f67fb83eea53c0922c84965d82e9e46c47f30b5c65406c4a14982e6" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/"dh-make-golang", "-type", "program", "github.com/isacikgoz/gitbatch"
  end
end
