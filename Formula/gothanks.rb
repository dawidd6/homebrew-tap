class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.3.0.tar.gz"
  sha256 "ce5440334b3eac2e058724faa4c6e4478ca1d81ea087e55ccca33f1996752aad"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/gothanks-0.3.0_2"
    sha256 cellar: :any_skip_relocation, big_sur:      "6347fe840a4d319e644d59fb1cb2399ea45663f3e9724cd5905dd3bf1f1e9082"
    sha256 cellar: :any_skip_relocation, catalina:     "f522dcd7f3070a9da1b3964514ec65b229a018ea9b9951db03b1fc4006d4d262"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9cf5e2af852548730a0dad89732ac5640120ca1c759dbc2c2c26dd2bf7c5ada9"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    ENV.delete "GITHUB_TOKEN"
    assert_match "no Github token found", shell_output(bin/"gothanks", 255)
  end
end
