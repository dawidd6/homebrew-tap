# Build
class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/dawidd6/dh-make-golang.git",
    :tag     => "v19.09.13",
    :revison => "420dcab5daa95a7919bded78e297706f20a25b59"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "13729000eda823e3bd73dc3059aeb58603dcb08e7d6239909f89ced55cc1869e" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
