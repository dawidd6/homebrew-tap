class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.2.0.tar.gz"
  sha256 "5ebb888cdf4b73139fb7cd27787a95e9e31cd15a2e8f51992be8a1bff6c0fcda"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/name
  end

  test do
    ENV.delete "GITHUB_TOKEN"
    assert_match "no Github token found", shell_output("#{bin/name}", 255)
  end
end
