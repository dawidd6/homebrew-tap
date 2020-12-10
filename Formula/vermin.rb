class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.121.0.tar.gz"
  sha256 "8fc4262921b545877574727cf3a177b7fb8b50ac92c716d16d89012f6851fa16"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/vermin-0.117.0"
    cellar :any_skip_relocation
    sha256 "f3758a8fa3726b8fed0006972da48175ece4f45e8338e9d0adb0d130312fade9" => :catalina
    sha256 "530bc3272d4d206ae2be17ddb3e6ed5f692c0b5c11f7b78d681c894d5c56e578" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
