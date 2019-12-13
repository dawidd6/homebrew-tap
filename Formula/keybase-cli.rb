class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.1.1.tar.gz"
  sha256 "72993e98534da64b1043c645741cd7f18f1453957a25d8b02481f8f8473f42f9"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "a9359cf143fa56595fc32d19ebd8af9df7cce3f23fca327fd78aa8933df909e1" => :catalina
    sha256 "843f22e143bb945dfc58005412742065e6ecd29d280d04f13d9f78bb114c1bf3" => :x86_64_linux
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
