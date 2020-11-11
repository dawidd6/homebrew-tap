class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.109.0.tar.gz"
  sha256 "586236e7f607c32f399ffc0ae48d621d369bd2445afc60dd2c79a8469c80263f"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
