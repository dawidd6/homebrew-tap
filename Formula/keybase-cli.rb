class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.2.1.tar.gz"
  sha256 "209860c9b8c8e7d24b93b53afa2865aea543c2b83a3110f822d54b569f4deffe"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "48346137af286c8902d7ed420a3f8134033bea29afa5702a2e776c3a3663c52f" => :catalina
    sha256 "a8c856333667ea3f1e2cda271a63e3b0742e0c0062ffc14b0c5a6ab750804a9f" => :x86_64_linux
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
