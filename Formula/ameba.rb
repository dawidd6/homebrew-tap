class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.4.tar.gz"
  sha256 "9da78230eb5d49370b106f998f30c78de1253a2c04742658153ba33bf6f201d2"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.13.3"
    cellar :any
    sha256 "b04cdbaed72f2635788d06a95178c34befd0f29c7a96b5c32e944b172020f2c0" => :big_sur
    sha256 "1eac40a21e5563e49deda7931d255b14d4a640152b0074ebbbf8441b1f06d284" => :catalina
    sha256 "5eebd706ef9d37b9c3480ad017178abbbda36156e9d5360ad1d8b661027c9aea" => :x86_64_linux
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
