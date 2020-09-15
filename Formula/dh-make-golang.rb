class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    tag:      "v0.3.3",
    revision: "c43abd765cf51c06bbcaa5479dc49aab1396989f"
  license "BSD-3-Clause"
  revision 2
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/dh-make-golang-0.3.3_2"
    cellar :any_skip_relocation
    sha256 "06e5bb6ddfcefd4ac983afd15912d4d7ef69fd64d8ca6f3c844562391126b7be" => :catalina
    sha256 "d37d7011cec634167eff8ba7265f6c7dbe2962a6a48c75568214b52468a46d32" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
