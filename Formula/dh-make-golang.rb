class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/Debian/dh-make-golang.git",
    :tag      => "v0.3.3",
    :revision => "c43abd765cf51c06bbcaa5479dc49aab1396989f"
  license "BSD-3-Clause"
  revision 1
  version_scheme 1
  head "https://github.com/Debian/dh-make-golang.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "75304d74ed29af3f490ccdc5657fc2e705fc23996123fa29c5fdba3de7bb6550" => :catalina
    sha256 "5183dc578bbd19d5de35e6bd541a60c277c60c65dc0cd72bcfb108b46060a732" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
