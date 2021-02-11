class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.6.1.tar.gz"
  sha256 "d54c2444e18b83e6c3f39c3d96ee87d1c178fd2812cda0718b70d10289b76685"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/keybase-cli-5.6.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "942a204545c2aaa7ee0468be8b2786418548780c1226b954b16af0432c269575"
    sha256 cellar: :any_skip_relocation, catalina:     "fb4aa7278a21df6ad29e3de9635fc6c3e7773d521e79cf523af8c97e39a35b4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0760b14765153192e629343b9a8dbd00ba9646962006c5912c52c8bb91e8a8ed"
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
