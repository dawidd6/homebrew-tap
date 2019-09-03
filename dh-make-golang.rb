class DhMakeGolang < Formula
  desc "Automatically creates Debian packaging for Go packages"
  homepage "https://github.com/Debian/dh-make-golang"
  head "https://github.com/dawidd6/dh-make-golang.git"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"#{name}"
  end

  test do
    system "true"
  end
end
