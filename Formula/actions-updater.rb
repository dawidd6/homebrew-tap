class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.8.tar.gz"
  sha256 "a4bb8393f46b346a504191c02da472aafbde95b476f6517ca641d7329e8e2d97"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "495e6cdab79414b9974ad346de97510a6fe756d94f36d8b6e17cc20fab68f843" => :catalina
    sha256 "665908d4de8cf8748185ae547bbdf9442af82fc4a3f15e8a81560f2f6c463de4" => :x86_64_linux
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
