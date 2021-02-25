class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.14.0.tar.gz"
  sha256 "1f2a8808874524306aa0189683e94424e6fcc95ef8dd4535a5df192c3a92ae8b"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.14.0"
    sha256 cellar: :any,                 catalina:     "9f10e8f9b2dad12652323a1c9db958cefba60433d54a35b96351e79489bfab71"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37ee3e26ca99dc5141b9a123a1a17938f1e841b805a0361ae22b4953403ce15e"
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
