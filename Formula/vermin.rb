class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.113.0.tar.gz"
  sha256 "a2bb77d9db1643fcf23430bb9e1b8eace0d1fcfbc803baa8d58b9ef9c238dad5"
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
