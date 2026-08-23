class Crib < Formula
  desc "Just Enough Devcontainers"
  homepage "https://fgrehm.github.io/crib/"
  url "https://github.com/fgrehm/crib/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "efa7e5bb9dd45173c888398ca2c22f3ef8ba8da63558e852cafeeea6403acf3e"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
    generate_completions_from_executable(bin/"crib", shell_parameter_format: :cobra)
  end

  test do
    assert_match "no container runtime found",
      shell_output("#{bin}/crib up 2>&1", 1)
  end
end
