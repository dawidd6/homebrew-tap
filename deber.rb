class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  head "#{homepage}.git"
  url "https://github.com/dawidd6/deber/archive/0.6.tar.gz"
  sha256 "2d05864c15a12db3aa542d1cda77de7a71ffb79adae86b1a3c8ca40095a39b59"
  depends_on "go" => :build

  def install
    system "go", "build", "-v", "-o", "#{bin}/#{name}"
  end

  test do
    system "#{bin}/#{name}", "--version"
  end
end
