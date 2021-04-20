class CloneOrg < Formula
  desc "Clone all repos of a github organization"
  homepage "https://github.com/caarlos0/clone-org"
  url "https://github.com/caarlos0/clone-org/archive/v1.3.0.tar.gz"
  sha256 "41b946e01160fe0c6b34ac7cf7d800bbd2b8fdc485e52019f2558382e1d4c66d"
  license "MIT"
  head "https://github.com/caarlos0/clone-org.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/clone-org-1.2.0_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "d2dc34d6456cda1da0f9fbdacd472d6eeb0106724719f6c7ccf1e5649382ac29"
    sha256 cellar: :any_skip_relocation, catalina:     "d524cbb1b09eccf3a6fa927389a851a82c961b90185a7daebf7c693c8192747d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "58c92a0c39ef217a20db43df0c263b522250d08b18023ceb536d0b10737b96a4"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
