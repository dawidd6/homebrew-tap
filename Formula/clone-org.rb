class CloneOrg < Formula
  desc "Clone all repos of a github organization"
  homepage "https://github.com/caarlos0/clone-org"
  url "https://github.com/caarlos0/clone-org/archive/v1.2.0.tar.gz"
  sha256 "930c1c71da669d45a9e8e006a1f2d5782c268bc35443bb7e648b7d1690936026"
  license "MIT"
  head "https://github.com/caarlos0/clone-org.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "732b783f6e47fc26dfc2d06b2a394c5a0f49055160b4e519e67029b430c31886" => :catalina
    sha256 "62c02fe12ed14c4802b4c47763317a448fbb23db63e21bcfbbd9ad38f6a556ea" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
