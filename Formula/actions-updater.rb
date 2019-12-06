class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.8.tar.gz"
  sha256 "a4bb8393f46b346a504191c02da472aafbde95b476f6517ca641d7329e8e2d97"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "c86fd7a5116d6e11e4a25fca00c957ce95f9e2eb41686d492438a09c4c740fb6" => :catalina
    sha256 "e3842266fd015b89f56bc04336164963dda2da1be7c28ea8d59e3313d6098f48" => :x86_64_linux
  end

  uses_from_macos "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "rake", "install"
    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    system bin/name
  end
end
