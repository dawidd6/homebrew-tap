class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v4.4.1.tar.gz"
  sha256 "dfac5ff4ecd5cd75f22ebece24c2e074cc83e38c7b207e074ca2c96ec3c96b7b"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "6f90ff414529a6683e0f954991d93280011b7d549ef1c426ecc5102a927fe6bd" => :mojave
    sha256 "4fc93e20f54f13399612b3d2eec0e0404658408cefd4b4c3a361908e6e8eabaf" => :x86_64_linux
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
