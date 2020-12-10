class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.122.0.tar.gz"
  sha256 "7cd48eb1c1127f3bac295ace92db2f9b84455ad5a13a26d7ccd87e8826cb97d6"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/vermin-0.121.0"
    cellar :any_skip_relocation
    sha256 "9234a23733ecdf26de00d812a3266366e9df27ae36c6087722d2a4464c54363a" => :catalina
    sha256 "bb529df79cc78e1c494429732f29a1d0cec806950b77f855e09c41b85f878f8a" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
