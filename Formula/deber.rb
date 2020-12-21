class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/v1.1.0.tar.gz"
  sha256 "b62e76e53773b5f978f00a157ed87fda2e4179e33461c7cc4082d7d7a51e9c7f"
  license "MIT"
  head "#{homepage}.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/deber-1.0.0_1"
    cellar :any_skip_relocation
    sha256 "4854097d48a1452de3df840be38e8a814f0a05d2a3ffaa175985cfa411e31967" => :big_sur
    sha256 "58861b90fe2d8e84547c5bd415ab6f4b3721553f639bc96ccda13c716c70a9be" => :catalina
    sha256 "54adecadd523a0cd2dbafb0c2fb3a6b902c574a14f2ec845b62655cfa118927e" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    v = shell_output "#{bin}/#{name} --version"
    assert_match "deber version #{version}", v
  end
end
