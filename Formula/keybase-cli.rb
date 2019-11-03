class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v4.7.2.tar.gz"
  sha256 "d6cf2ac1f13bd95c713a534ec504fe20556bd8da93bb5cfe1cdcb6287ed1fc4d"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "7841784896f70c474b6de477826da3f731136853297ba104d379a5e39338220b" => :mojave
    sha256 "808df878283b27d4cb57567e78b58dfee0626f44c80d6823dac3df6a14c08cf1" => :x86_64_linux
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
