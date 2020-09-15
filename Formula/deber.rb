class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/v1.0.0.tar.gz"
  sha256 "924d8dd9c12514c6c27f75f2ed64b222d3db84383de240c3eaefb22f9ca7e779"
  license "MIT"
  revision 1
  head "#{homepage}.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "97ab88ffeca00691b3cc0847155907fc6e372c2d22f254866b9060ff5eceda02" => :catalina
    sha256 "591a86d23ab3ca3b20843e62ea36832b19b4e489c72542b4815dbb32b9fd0355" => :x86_64_linux
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
