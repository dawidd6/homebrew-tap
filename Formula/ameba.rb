class Ameba < Formula
  desc "A static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.12.0.tar.gz"
  sha256 "1709db9de850430b38b38998fa38bf70c237925c6072bf78dfa51ad66cabdb57"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "662ab9d6e836a07228bd4ca24c90211f0fb8ea2362a8472ec77ac9375b27e898" => :catalina
    sha256 "31789fae4d0e03c5646ce0ce3092ef77adbe4ff6c3acf2d2b13d6c2dd8e019c7" => :x86_64_linux
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
