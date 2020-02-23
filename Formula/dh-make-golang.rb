class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    :tag      => "v0.3.2",
    :revision => "82916c0d56b6319398f635199222dff397fafc12"
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "8734ab11809bab390d62c59376e855d1e9c7add9ba80d066974c7cd19433f1d6" => :catalina
    sha256 "ea432a495f0d65a2482fccf042e35d4c06fd78014da88527240c2d990996861e" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
