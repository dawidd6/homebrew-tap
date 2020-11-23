class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.113.0.tar.gz"
  sha256 "a2bb77d9db1643fcf23430bb9e1b8eace0d1fcfbc803baa8d58b9ef9c238dad5"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/vermin-0.113.0"
    cellar :any_skip_relocation
    sha256 "fd2613116fe65ac54cdde028989e272d9252f3dc006a2cae9ecad83603d4651b" => :catalina
    sha256 "16a2ebe440f125413ea11d72400bbc12d7b96a99de48de7c2fa311b494f78887" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
