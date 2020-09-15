class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.5.1.tar.gz"
  sha256 "a65dc4b62fc1299dd17da52ddd2484fa1dc1e7d2a4776c3a6e112ee020980b12"
  license "BSD-3-Clause"
  revision 1

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/keybase-cli-5.5.1_1"
    cellar :any_skip_relocation
    sha256 "46f49f7c6b6408488e145df91506165f69355c7a01dbaa335d7851d1bb7c447d" => :catalina
    sha256 "256e81ab116ade9810f4ee9b61a92ce51cf80aa604cde51e03c9418906daedda" => :x86_64_linux
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
