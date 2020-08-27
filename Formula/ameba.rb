class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.2.tar.gz"
  sha256 "7ae91a3e1b32cfed595db090ddea065dd177fb3591de9730606f9f32d340c180"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any
    rebuild 1
    sha256 "08065a11acb3f0427e7d44b04438b3a937d2fccc043ae16a02b4f0cd2a2745e9" => :catalina
    sha256 "f83b27e0f627fef551a21b0c1e8391a284eeff5285d980c234259e60ac51e6c9" => :x86_64_linux
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
