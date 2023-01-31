class Deber < Formula
  desc "Debian packaging with Docker and Kubernetes"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/v1.1.1.tar.gz"
  sha256 "572138f94ef1ae2391a58985ccd450573aa0011395ac4414c88bd5ff22921ad3"
  license "MIT"
  head "#{homepage}.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/deber-1.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "a6559dddda1fa1ec87b3ebad6e4d8347acad404fd1fa7117103cdf3bfdb31cd8"
    sha256 cellar: :any_skip_relocation, catalina:     "1d50425636b629871afaae22df5264a5fe303b7e3ccb00113d8a0bb0a3061eab"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c310bd6bd59ba590f3848e6dec25a64511e2aff2d7b5b780277ad9a48892fc0f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    v = shell_output "#{bin}/#{name} --version"
    assert_match "deber version #{version}", v
  end
end
