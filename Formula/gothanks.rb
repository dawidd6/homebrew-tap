class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.2.0.tar.gz"
  sha256 "5ebb888cdf4b73139fb7cd27787a95e9e31cd15a2e8f51992be8a1bff6c0fcda"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "962741adced6e4f0736951e5aefa6c24591bc61342f676af3a6fbefc46bac69d" => :catalina
    sha256 "8cc94c61c6c87ea9d211de5fccafe3bb65ffbea02ccf7a851410e8f47dfb120b" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    ENV.delete "GITHUB_TOKEN"
    assert_match "no Github token found", shell_output(bin/"gothanks", 255)
  end
end
