class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  url "https://github.com/dawidd6/dh-make-golang.git",
    :tag     => "v19.09.13",
    :revison => "420dcab5daa95a7919bded78e297706f20a25b59"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    system bin/name, "search", "wuzz"
  end
end
