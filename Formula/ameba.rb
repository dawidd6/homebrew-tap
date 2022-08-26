class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v1.1.0.tar.gz"
  sha256 "1fb470ea6d3eda81cb72336b35e2dd7f1f82f27752d37fe08232542eba127f6a"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-1.0.1"
    sha256 big_sur:      "9baa30928ae5efe7a5cbb69a2d3f10f109f649cd907af276ae4e4f010b3a3ed0"
    sha256 x86_64_linux: "bef2f537f7030dc06c6e562d558968e3a1226ee301a4cb4a8879f18474261c9f"
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
