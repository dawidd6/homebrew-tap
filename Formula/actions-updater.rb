class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.3.tar.gz"
  sha256 "9bce43e99d947d7f27599b0fac0bf672a2ba39b34630e7447d0bd27053da37bd"
  head "https://github.com/dawidd6/actions-updater.git"

  uses_from_macos "ruby"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/name
  end
end
