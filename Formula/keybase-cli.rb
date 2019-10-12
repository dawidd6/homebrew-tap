class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v4.6.0.tar.gz"
  sha256 "ee97b78e27dc77f55e0533dfbf4ecde2563c14e0f8c708cdb6066361c56ff8f8"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "03e9f65161b93e6516daa20eb1345a79d8d6915bf8c73f946e78cf676bca63a1" => :mojave
    sha256 "4e1e26a313659f11d0c9cbd4fc56d10d80acd045bed577ff43faf79052af0270" => :x86_64_linux
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
