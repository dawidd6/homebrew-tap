class CloneOrg < Formula
  desc "Clone all repos of a github organization"
  homepage "https://github.com/caarlos0/clone-org"
  url "https://github.com/caarlos0/clone-org/archive/v1.4.0.tar.gz"
  sha256 "93f56f023a8abcecf53c523ffabedbb9971f355f29d481ce7abdb62dd3a33c99"
  license "MIT"
  head "https://github.com/caarlos0/clone-org.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/clone-org-1.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7d1aeb2f1fec294ce49e895368be08fe6a488f9003fa22350c50c0ac3c778f9a"
    sha256 cellar: :any_skip_relocation, catalina:     "129aca82085295dfc44cf458713ca55ebf9575c7473b92c7c87a78cae699ade0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "068eff64d267d27b799aef10dd9d19755f547763f76747e8a0499f42b6858829"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}", "./cmd/clone-org"
  end

  test do
    assert_equal "clone-org version #{version}", shell_output("#{bin}/clone-org -v").chomp
  end
end
