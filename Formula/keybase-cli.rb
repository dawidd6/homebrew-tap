class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.3.1.tar.gz"
  sha256 "6bff8f3e892bcfda21a608ae1c38f8d5428882b517f61e2dc429259ff07e30cb"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "2955be84b916b82b8413396e0a650a62b98924932ef5093340a9b0c3c48db494" => :catalina
    sha256 "a5d0abac4a3f50c2d85f93709b3c6ffeeaa079e3ac70df98588fe00ca91bd493" => :x86_64_linux
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
