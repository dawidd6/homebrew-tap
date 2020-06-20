class Ameba < Formula
  desc "Static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.13.0.tar.gz"
  sha256 "33826262a9e48f1ede313644802ba24780009e8ea471e1e45b99e03016fef82e"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "89bbf9b701cbe82aa4c20e40d5e25706212b022bbde047eb0f6e872cd0ff03a3" => :catalina
    sha256 "2ec477dae7371bbbfbff4d44322fd2b5237ee7f9a0e0790fbe0d9d432a2e081d" => :x86_64_linux
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
