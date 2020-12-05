class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.3.tar.gz"
  sha256 "e725aa45a701b6f89409a69742ac0c17b9d15af0743b3be013ff1b6b82d685a2"
  license "MIT"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/ameba-0.13.2_1"
    cellar :any
    sha256 "3b88814669482d5c6b89fd869a2c476bd431e5ded4b211674428fe53d1f020e6" => :big_sur
    sha256 "fe02e383d1a7480274ec6dab20ef89b163c1b579a9a242c826f731c4c057a565" => :catalina
    sha256 "cea9d9a6d5e156e4b1f2a5763e535443a0994ffd4162d2f0e5c3471c817b1c14" => :x86_64_linux
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
