class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v1.0.0.tar.gz"
  sha256 "ab178cc49e39d77781111306e91a80aa63535c54725210091e3e32c9862a227a"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-1.0.0"
    sha256 cellar: :any,                 big_sur:      "9d2f7ee2fa5644210ee127d69d08a908fc299455e88f59b717f5f20e290452b6"
    sha256 cellar: :any,                 catalina:     "79c4b8458476b8ae8cbc76dafb50ce6d62707b7db7d30df51e563b36313fd335"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7a88f9b394855c30349d9206f8b41e93dca76914901e07b187e2070d901d66a2"
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
