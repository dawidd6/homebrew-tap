class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.4.2.tar.gz"
  sha256 "74b7c51d187bb756182b4ccd4e7e9d10b63c87fbc58632fcbef6e05bf1e15035"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "2206b0b558547ec3b965b9c61d514575c37175a5e9a35d4c58665dd067083ddf" => :catalina
    sha256 "14ac85b84908252110270b832c7ba0fe226a1f408275f64a39c6681686c13d77" => :x86_64_linux
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
