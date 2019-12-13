class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.1.1.tar.gz"
  sha256 "72993e98534da64b1043c645741cd7f18f1453957a25d8b02481f8f8473f42f9"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "8ae1518f52196edead9c709c7c0b4f18149bd9cfa10fce79d2108c98122e001d" => :catalina
    sha256 "825cfe7ec51b9c7feab940beccd5c40889182a11d04a88693f2b2df5125adf43" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/keybase/client/").install "go"
    system "go", "build", "-tags", "production", "-o", bin/"keybase", "github.com/keybase/client/go/keybase"
  end

  test do
    ENV["KEYBASE_ALLOW_ROOT"] = "true"
    system bin/"keybase", "--standalone", "id", "homebrew"
  end
end
