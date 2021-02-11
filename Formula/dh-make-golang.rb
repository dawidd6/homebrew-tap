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
    sha256 cellar: :any_skip_relocation, big_sur:      "d0134dd842ae3addc2a23cd6eb4907033e63e03ccdf2b87d08d8cc56642c4c25"
    sha256 cellar: :any_skip_relocation, catalina:     "5198eb6526ae0b81d3bd62bc3e482b20f7db66b6fd559a8d2bc01aaf948d0ead"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7d15fbffa0241b110ef9923d3f23db75b2f369d620a6da69b581d302484a9fbe"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
