class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.4.tar.gz"
  sha256 "33c21c15395ef33bc3f49badb9ad92d2bef912be00082c296b5092c507b7ad50"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "29be35a0c4072f8e9fce352953d7ca5e032defb5dc8dd81aa0c11dbd7dd9cf60" => :catalina
    sha256 "ed02b915ce1b4ec94baf77984eb8f1b0f053e83b3042f97893c98e09d62fb977" => :x86_64_linux
  end

  uses_from_macos "ruby"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/name
  end
end
