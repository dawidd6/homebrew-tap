class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.6.1.tar.gz"
  sha256 "d54c2444e18b83e6c3f39c3d96ee87d1c178fd2812cda0718b70d10289b76685"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/keybase-cli-5.5.2"
    cellar :any_skip_relocation
    sha256 "15258bb10e019649142ac2a01c4784542ae1dcf5ed2d7e5288d8fdf362276988" => :big_sur
    sha256 "aabcdba144a062657e9ad9c03286544f3e2b729a8c30287f59dfdd715250eb66" => :catalina
    sha256 "a110652139bdc99e3b5440da3fa89a43d0d23074a32007a11fa3715b70088624" => :x86_64_linux
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
