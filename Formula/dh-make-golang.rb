class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/dawidd6/dh-make-golang.git",
    :tag     => "v19.09.13",
    :revison => "420dcab5daa95a7919bded78e297706f20a25b59"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "1a0750ac9311134d9c8977ba120c581f6a0d4b144b667976812d9e2e5be25198" => :catalina
    sha256 "ac5e7c96b2c8f2b9a865d6f8a4482514281ad81776feebdb6c0397e9087b5bed" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
