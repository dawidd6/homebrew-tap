class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.14.2.tar.gz"
  sha256 "eaed2c8798d0e1964505307e51515d67abc34481ec353a6b4085a025a3fce383"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.14.2"
    sha256 cellar: :any, big_sur:  "2cf7e747c23ebb149cc49825a63542d988b0a19fd86bc1a3abc4e97536352dcc"
    sha256 cellar: :any, catalina: "ba45f55be0be9aedf04882d7e725428bc4259109baf8eeb50621d586863fc227"
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
