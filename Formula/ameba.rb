class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.12.1.tar.gz"
  sha256 "23ae1671cde9d32ebaeffe677ef5392c2e4c82c9cc5467b8954796898f8fd88d"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any
    sha256 "2667edf86ea1c7e49ea21250a4c8049c13d17c2bafa0a36a31e81f071c6cf83e" => :catalina
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
