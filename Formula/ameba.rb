class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.4.tar.gz"
  sha256 "9da78230eb5d49370b106f998f30c78de1253a2c04742658153ba33bf6f201d2"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.13.4"
    cellar :any
    sha256 "bd7c00559c8691f2d33c706e79eef48b2dd52cf617754b3d07c8abbe83794a3e" => :big_sur
    sha256 "16bbf4710c2dd0e48e44ef1d9bde99fd57eb243ded796035af9a202c170c8d16" => :catalina
    sha256 "00fe7c95b9550b7b24afe910155fd4b0a580293bb86d27212affacadc5c954f2" => :x86_64_linux
  end

  depends_on "crystal" => :build
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"main.cr").write <<~EOS
      require 'json'
    EOS
    assert_match "use double quotes for strings", shell_output("#{bin}/#{name} main.cr", 1)
  end
end
