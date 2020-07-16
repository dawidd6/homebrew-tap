class CloneOrg < Formula
  desc "Clone all repos of a github organization"
  homepage "https://github.com/caarlos0/clone-org"
  url "https://github.com/caarlos0/clone-org/archive/v1.1.2.tar.gz"
  sha256 "5d8ffd94da079ea4eec57ed3b11977edb316ee1e510bbd4bdc4915905b8d8dd1"
  head "https://github.com/caarlos0/clone-org.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "1fbedf4faee79c5f8a90e7dc9f7607f1b9753d81b6a0568a97506198603b8d75" => :catalina
    sha256 "2ada5ffeaf60dafde8dccaf1257306543a8f82a1338cb4baa5d82ed72ef61114" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
