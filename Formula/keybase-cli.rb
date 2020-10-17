class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.5.2.tar.gz"
  sha256 "2610dbc44d84b93822f9e4ec510aac473116c953f1073a45aef983898a2289fd"
  license "BSD-3-Clause"

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
