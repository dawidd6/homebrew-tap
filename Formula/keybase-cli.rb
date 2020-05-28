class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.5.1.tar.gz"
  sha256 "a65dc4b62fc1299dd17da52ddd2484fa1dc1e7d2a4776c3a6e112ee020980b12"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "1fb41c6484f83b96bb1c264c067ea7b11297e954f0bae42ae470338b89850955" => :catalina
    sha256 "28e35c216be623cbb6b3c56110a62220a5f5aaaf9058933cf51374054b29cbba" => :x86_64_linux
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
