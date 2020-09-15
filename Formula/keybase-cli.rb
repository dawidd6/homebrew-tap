class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.5.1.tar.gz"
  sha256 "a65dc4b62fc1299dd17da52ddd2484fa1dc1e7d2a4776c3a6e112ee020980b12"
  license "BSD-3-Clause"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "2d06d0fccf9e625c5139224aba1764f035d661759911776b251a20a211c95050" => :catalina
    sha256 "38b73f88d4790989b146c77ecfc5fb1867c9c30e704490efd825a2809a90394f" => :x86_64_linux
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
