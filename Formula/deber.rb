class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/0.6.2.tar.gz"
  sha256 "1c1e75bf36b6a2b412faec793f904f09b65c6e1ebf00f718096ea6a6698be359"
  head "#{homepage}.git"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "afff04e105fc85d1da706e794781c97aa4920c1c7e9c41610b87636e0d713b1b" => :mojave
    sha256 "c4142aeeb6f2f4cda54251cc46027de1dbf59a3478a6eb53662547232f56bce8" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor", "-o", "#{bin}/#{name}"
  end

  test do
    system "#{bin}/#{name}", "--version"
  end
end
