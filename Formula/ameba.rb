class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.1.tar.gz"
  sha256 "e22dbee65526669f17507bfdc93f3a076fd519d62264906e9c955f555bde5351"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any
    sha256 "7a0e38950874a303e39072078cae7299ff0a2359ab808f8f099a3b1795df338c" => :catalina
    sha256 "ba9fc652beef3cc7fb415820c0084190aba3868e4e51b09c42534e65d566e2e6" => :x86_64_linux
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
