class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    tag:      "v0.6.0",
    revision: "1f3d77058a1bb9edadad78dbb0ad479cc26000cf"
  license "BSD-3-Clause"
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/dh-make-golang-0.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "569f75525f9da6195733c2560f61caf33d0169d9cc56736bbab4ef58738b64a5"
    sha256 cellar: :any_skip_relocation, catalina:     "5865edecc64cff59f0fdee07e09f10db0c9e36fd311c6438060e070461bd0819"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "573fc2adba8eb2bde7789469139983c551bc600e5c4743c939d16ca5d4107f66"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
