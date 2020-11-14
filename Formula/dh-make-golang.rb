class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    tag:      "v0.4.0",
    revision: "3671570fd0c4668c64abf941d58a9c8adfe6b396"
  license "BSD-3-Clause"
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/dh-make-golang-0.4.0"
    cellar :any_skip_relocation
    sha256 "5198eb6526ae0b81d3bd62bc3e482b20f7db66b6fd559a8d2bc01aaf948d0ead" => :catalina
    sha256 "7d15fbffa0241b110ef9923d3f23db75b2f369d620a6da69b581d302484a9fbe" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
