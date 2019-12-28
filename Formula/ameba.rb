class Ameba < Formula
  desc "A static code analysis tool for Crystal"
  homepage "https://crystal-ameba.github.io"
  url "https://github.com/crystal-ameba/ameba/archive/v0.11.0.tar.gz"
  sha256 "b402f56a74b7e4cc951be0d5da3ac466e366a1d8b4f3adfe852884375173fa68"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "0e623718d42cabc855bcbbd1f24ecc8dc2163235f73019a9193e4a4648d68b37" => :catalina
    sha256 "5643a3c26172eb06416a10e86c6da6e994b72cff3be211794b767353db6d690c" => :x86_64_linux
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
