class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.2.tar.gz"
  sha256 "7ae91a3e1b32cfed595db090ddea065dd177fb3591de9730606f9f32d340c180"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any
    sha256 "5d031f6a2d003a80601e19ca1043f201c6f15cf8e69852f7b9c5ca6fa2506466" => :catalina
    sha256 "20475f9f33aefc2074d40234c45fc1d6e3014a7db545739d7a5e6c69095a8018" => :x86_64_linux
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
