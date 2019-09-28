class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/dawidd6/dh-make-golang.git",
    :tag     => "v19.09.13",
    :revison => "420dcab5daa95a7919bded78e297706f20a25b59"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    prefix "/home/linuxbrew/.linuxbrew"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4f1c4b8576690a12f2ae435ccd6c0f1c90feb796783b049a40b34d3b50585792" => :mojave
    sha256 "a5496d27c217569b33b551923cf73ba3f3ca1548986a97fdd479df27e71332a2" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
