class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v4.7.2.tar.gz"
  sha256 "d6cf2ac1f13bd95c713a534ec504fe20556bd8da93bb5cfe1cdcb6287ed1fc4d"
  revision 1

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
