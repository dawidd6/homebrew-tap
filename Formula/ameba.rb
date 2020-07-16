class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.1.tar.gz"
  sha256 "e22dbee65526669f17507bfdc93f3a076fd519d62264906e9c955f555bde5351"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "6c8a400ee85dce22c2500d5d1c602267f17a95afc9c5ff02b96c620272a48c4b" => :catalina
    sha256 "e3db202f8cb1329cdee9672b8a058511648721233755692d3ceeace6e17aaaea" => :x86_64_linux
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
