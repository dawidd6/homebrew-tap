class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.5.0.tar.gz"
  sha256 "9e6b3d4d71e111cdc616c3b50ddc41cc9c4d86ff03dc658fd1d5ed55e1c43f8f"

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
