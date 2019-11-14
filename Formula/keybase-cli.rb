class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.0.0.tar.gz"
  sha256 "901f4c15e27ec46be3e05137adf5837d4bcf61523d9ab07d40408d8857388163"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "540fce3c5e484ee5a99a300275fd9c166a2dde1bd4843de120199b2f9b64d77d" => :catalina
    sha256 "016328c3948107603928a0cf3f2d3b69a2eb55c2bd53d98a6dc1b8f6606a8ab7" => :x86_64_linux
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
