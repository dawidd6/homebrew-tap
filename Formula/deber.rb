class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/v1.0.0.tar.gz"
  sha256 "924d8dd9c12514c6c27f75f2ed64b222d3db84383de240c3eaefb22f9ca7e779"
  head "#{homepage}.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "00725ee967473f897c926022892aba9f346f59116bf0a11345bec7022b56dbdb" => :catalina
    sha256 "0b443f2b2c4c97eac81cb82de16ce5acc5075b5a1a5631288e8140dcfb196e51" => :x86_64_linux
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
