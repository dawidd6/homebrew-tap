class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go AND Java packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    tag:      "v0.6.0",
    revision: "1f3d77058a1bb9edadad78dbb0ad479cc26000cf"
  license "BSD-3-Clause"
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/dh-make-golang-0.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "1de1fe6dc5f6827c35326dc9ad4eed3238cd065d947803a3f2f84678cba3e06c"
    sha256 cellar: :any_skip_relocation, catalina:     "bba64b1f770c289c6f211794749fcc037c01fe1a8bea577dc0a8794e61d0aa6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f6445a4111fe25ec4bd5612574048571b8fafb7d48ce2ab3a201ef03cd2a93cd"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
