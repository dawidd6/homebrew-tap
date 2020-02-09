class KeybaseCli < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io"
  url "https://github.com/keybase/client/archive/v5.2.0.tar.gz"
  sha256 "fa3a9e64532122f587847a19082a291b5964a4ce75f4f18dc20f1eae6c147e8d"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "59fba1aef6538bfbbcceb1b9f9c09ce6c4794223fd39609e80b3349204f6a136" => :catalina
    sha256 "d535d064c920a06bab5c2c79cc2d0b5bbd9d1068cae245cf851a4d9b2e81b8a7" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/keybase/client/").install "go"
    system "go", "build", "-tags", "production", "-o", bin/"keybase", "github.com/keybase/client/go/keybase"
  end

  test do
    ENV["KEYBASE_ALLOW_ROOT"] = "true"
    system bin/"keybase", "--standalone", "id", "homebrew"
  end
end
