class Deber < Formula
  desc "Debian packaging with Docker and Kubernetes"
  homepage "https://github.com/dawidd6/deber"
  url "https://github.com/dawidd6/deber/archive/v1.1.1.tar.gz"
  sha256 "572138f94ef1ae2391a58985ccd450573aa0011395ac4414c88bd5ff22921ad3"
  license "MIT"
  head "#{homepage}.git"

  bottle do
    root_url "https://github.com/tedim52/homebrew-tap/releases/download/deber-1.1.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c2e1f246a54524a38f5bcf0cb495687067b21aca7b36bb42ebbb8b493ca2fc3"
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
