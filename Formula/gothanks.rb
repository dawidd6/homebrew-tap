class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.4.0.tar.gz"
  sha256 "300b705751a43f6ae25df57d6c9a5b0c859e92d61fa83cf894329ea9662525f2"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/gothanks-0.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "8b4780f8bcedf64e31e3eff64788d4ec8637e22dc9894f2ebd4fc5732ecc1471"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98290da431c83670179da9cc96f8fdf2e1bf2d535c5dd3868ae7a70c95a3f739"
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
