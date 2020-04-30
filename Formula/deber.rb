class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/v1.0.0.tar.gz"
  sha256 "924d8dd9c12514c6c27f75f2ed64b222d3db84383de240c3eaefb22f9ca7e779"
  revision 1
  head "#{homepage}.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "d16a2b33bfeefd414692f8d693b4acd0074466cc9102035c2f851106abe5704f" => :catalina
    sha256 "223996b71bc38c3f59165938f8772af1bb0fa7fc464a272adf6c67e07ae11ce0" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor", "-o", "#{bin}/#{name}"
  end

  test do
    v = shell_output "#{bin}/#{name} --version"
    assert_match "deber version #{version}", v
  end
end
