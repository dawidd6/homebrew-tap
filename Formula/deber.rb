# Build
class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/0.6.2.tar.gz"
  sha256 "1c1e75bf36b6a2b412faec793f904f09b65c6e1ebf00f718096ea6a6698be359"
  head "#{homepage}.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "e563b2f8094b998e0b221f911b1816b9a8b321af00eee74272679474c423aa7f" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor", "-o", "#{bin}/#{name}"
  end

  test do
    system "#{bin}/#{name}", "--version"
  end
end
