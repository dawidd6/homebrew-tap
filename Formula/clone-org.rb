class CloneOrg < Formula
  desc "Clone all repos of a github organization"
  homepage "https://github.com/caarlos0/clone-org"
  url "https://github.com/caarlos0/clone-org/archive/v1.1.1.tar.gz"
  sha256 "f925d286e154566a29e8b12580a2dbb127de205d03f1f8980524f21da2fcffc9"
  revision 1
  head "https://github.com/caarlos0/clone-org.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "9234c0062e22b644d4764aec524da1a34000a2661f4ec6b4eff05948768964c8" => :catalina
    sha256 "95c502d2fcb437a900d1fa3482457df7dbfa85d1ecd86034382f9c1c0508f422" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
