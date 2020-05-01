class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.3.0.tar.gz"
  sha256 "ce5440334b3eac2e058724faa4c6e4478ca1d81ea087e55ccca33f1996752aad"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "cf93c11b3be457ff5980936dc58399146287e33de45e1dab61117bd44db31c68" => :catalina
    sha256 "f973a922689fc5d77c71039af031c71aaea6bab564ef6084ad02713dc3b2e7d2" => :x86_64_linux
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
