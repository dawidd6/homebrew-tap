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
    sha256 "dde1314730bc6823f726372ede289ff435d2f7d5a82e4365c34396aac2e601ae" => :catalina
    sha256 "d636f98f6880f5980f1832e5310ac63d72c9e40977dd3a58f29f562ffd85c7e6" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
