class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  head "#{homepage}.git"
  url "https://github.com/dawidd6/deber/archive/0.6.2.tar.gz"
  sha256 "1c1e75bf36b6a2b412faec793f904f09b65c6e1ebf00f718096ea6a6698be359"

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor", "-o", "#{bin}/#{name}"
    system "echo", "TESTINGGGGGGGGGGGGGGGGGGGGGGGGG"
  end

  test do
    system "#{bin}/#{name}", "--version"
  end
end
