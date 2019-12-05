class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.5.tar.gz"
  sha256 "8683ba95588e74adc08f37983059eb174076f51f29baada0f749d2de339abb0f"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "6099ead9ab70176774dfd869b47c320afc5a8f8ce245209159f843dc944e1d5f" => :catalina
    sha256 "4d6fc039d9e360ee08197db937e6f14ae7e9752ffec98d9fca9f3e14b45a593a" => :x86_64_linux
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
