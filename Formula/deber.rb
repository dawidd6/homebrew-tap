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
