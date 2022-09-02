class Fvm < Formula
  desc "Flutter Version Management"
  homepage "https://fvm.app"
  url "https://github.com/fluttertools/fvm/archive/refs/tags/2.4.1.tar.gz"
  sha256 "578ddc4cc63656938afbfa971e08325d22af1ce4487cb264753dd829e419646b"
  license "MIT"

  depends_on "dart-sdk" => :build

  def install
    system "dart", "pub", "get"
    system "dart", "compile", "exe", "bin/main.dart", "-o", name
    bin.install name
  end

  test do
    output = shell_output("#{bin}/fvm list", 64)
    assert_match "No SDKs have been installed yet", output
  end
end
