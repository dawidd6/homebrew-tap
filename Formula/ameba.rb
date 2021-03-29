class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.14.2.tar.gz"
  sha256 "eaed2c8798d0e1964505307e51515d67abc34481ec353a6b4085a025a3fce383"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.14.1"
    sha256 cellar: :any, big_sur:  "8979054a17a43df4d75528b30b2c37c05272248ef417980acc67ceba5d2817a4"
    sha256 cellar: :any, catalina: "aa7356544aba27ec1b6c2c0e5982993a2848ac34516e83349ecd4752a22c1ce0"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
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
