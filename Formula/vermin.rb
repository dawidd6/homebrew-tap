class Vermin < Formula
  desc "Smart virtual machines manager supporting Vagrant boxes"
  homepage "https://mhewedy.github.io/vermin"
  url "https://github.com/mhewedy/vermin/archive/v0.126.0.tar.gz"
  sha256 "01d314788feb03f15a517477208930f7b6740b3ccc482686c709d62e72e5d361"
  license "Apache-2.0"
  head "https://github.com/mhewedy/vermin.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/vermin-0.126.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "6385c66f6b2f3333550eacf626887bc439dbd9b00b3418591a695d7b2476d9c2"
    sha256 cellar: :any_skip_relocation, catalina:     "21c1e9f4f557f1b7167944222dbb317b573b96337399b7fa92d5a38fad763364"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c43a0220d9c5ba13b833fb6b8cc1026f4e0ba70957981de740e266a3e232cb88"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "ubuntu", shell_output("#{bin}/vermin images")
  end
end
