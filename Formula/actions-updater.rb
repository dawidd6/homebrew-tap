class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.4.tar.gz"
  sha256 "33c21c15395ef33bc3f49badb9ad92d2bef912be00082c296b5092c507b7ad50"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "f84be297b1f1820872ecc648676bbeec9d872330cdfb86bf272ed039a208bd3b" => :catalina
    sha256 "f79c8d58afbf0b0ea423aa3b03d126ca226330df391384d01b222b9d6f88ec3c" => :x86_64_linux
  end

  uses_from_macos "ruby"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/name
  end
end
