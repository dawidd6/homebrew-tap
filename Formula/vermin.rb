class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.109.0.tar.gz"
  sha256 "586236e7f607c32f399ffc0ae48d621d369bd2445afc60dd2c79a8469c80263f"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/vermin-0.109.0"
    cellar :any_skip_relocation
    sha256 "74d1242dedc84fec338bf17c03514593150f71f1b510f16e91bb2d827e171bb2" => :catalina
    sha256 "59cc50f3682a0f758b52675b55059c08ff156d9459d35a4306ef44c42b453b9b" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
