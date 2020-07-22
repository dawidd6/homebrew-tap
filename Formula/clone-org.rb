class CloneOrg < Formula
  desc "Clone all repos of a github organization"
  homepage "https://github.com/caarlos0/clone-org"
  url "https://github.com/caarlos0/clone-org/archive/v1.1.2.tar.gz"
  sha256 "5d8ffd94da079ea4eec57ed3b11977edb316ee1e510bbd4bdc4915905b8d8dd1"
  license "MIT"
  head "https://github.com/caarlos0/clone-org.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "39c4ea812cea64052f55da3fcfca8ae54dfb1ef82cddf6d43c13632e3e6848ef" => :catalina
    sha256 "8bc27eee9bb7b2f610bb3e64f58fe941f1235f37b5943a5b6479747b041b0886" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
