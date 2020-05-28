class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.5.1.tar.gz"
  sha256 "a65dc4b62fc1299dd17da52ddd2484fa1dc1e7d2a4776c3a6e112ee020980b12"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "bac25ce723d547aaef79f5499085876fb96a4e7ec0ab7b12615b8e4128e1d3e8" => :catalina
    sha256 "54c2840be1a201d4e153605c435642c08da2acf5d8e1d32cd1c1ebae9a2bcf3a" => :x86_64_linux
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
