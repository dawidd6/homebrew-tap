class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v4.7.2.tar.gz"
  sha256 "d6cf2ac1f13bd95c713a534ec504fe20556bd8da93bb5cfe1cdcb6287ed1fc4d"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "fb5566f9b024e491e8e092cc0d6f220730f3661b77a5eb138faeb6dd33b93b1f" => :mojave
    sha256 "cd0e43b21d7adc32f79031290ee34d6403a9a85750c05c697d0b47bcaf7b2f85" => :x86_64_linux
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
