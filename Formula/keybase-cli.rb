class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v4.4.1.tar.gz"
  sha256 "dfac5ff4ecd5cd75f22ebece24c2e074cc83e38c7b207e074ca2c96ec3c96b7b"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "7d9941db13c89b62aee8aba00ddf84dcaa2b94bfcdd24e7a139ade9600e59509" => :x86_64_linux
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
