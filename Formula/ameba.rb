class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v1.0.0.tar.gz"
  sha256 "ab178cc49e39d77781111306e91a80aa63535c54725210091e3e32c9862a227a"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.14.2"
    sha256 cellar: :any,                 big_sur:      "2cf7e747c23ebb149cc49825a63542d988b0a19fd86bc1a3abc4e97536352dcc"
    sha256 cellar: :any,                 catalina:     "ba45f55be0be9aedf04882d7e725428bc4259109baf8eeb50621d586863fc227"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d2afea1bfab4550b934f6dfd96bfcc3a71cfe56ae3db0362488c509f6a75619b"
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
