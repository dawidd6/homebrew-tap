class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.125.0.tar.gz"
  sha256 "cf6d9c1513ee9f1426b702a1f5aff3d3076c919ab227a2dc0664a96fb74b9033"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/vermin-0.125.0"
    cellar :any_skip_relocation
    sha256 "cf2d01b7a4d57a8a2f86366901b975e78b2672d2d6c65c345e79459c44ac2bac" => :big_sur
    sha256 "bf94fd526912be84c9a7134b5ffba165e8323a41bf033895b36807b95475c6cc" => :catalina
    sha256 "efe87000a2bae967226b3facced5c3b534c1586405161cf3c04121df01f08977" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
