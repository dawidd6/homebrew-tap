class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.4.2.tar.gz"
  sha256 "74b7c51d187bb756182b4ccd4e7e9d10b63c87fbc58632fcbef6e05bf1e15035"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "d8271e303f2d9beec082c194167e468d7f769d247494bdbe800bdaf2bbc41ab9" => :catalina
    sha256 "98e4791b287505358331dfadd14ad96963e8a1a463128ed8fb6c76a790363366" => :x86_64_linux
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
