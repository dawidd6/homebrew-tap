class Gothanks < Formula
  desc "Automatically star your go.mod Github dependencies"
  homepage "https://github.com/psampaz/gothanks"
  url "https://github.com/psampaz/gothanks/archive/v0.2.0.tar.gz"
  sha256 "5ebb888cdf4b73139fb7cd27787a95e9e31cd15a2e8f51992be8a1bff6c0fcda"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "fc71bba7c875df809a620dd70a94f165eb2db50505330b71703fa6ab98bc3b94" => :catalina
    sha256 "1d18e7a87e42a477ea477dba68c5371bc9b34f69e0317761050e880d814ea862" => :x86_64_linux
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
