class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.5.tar.gz"
  sha256 "8683ba95588e74adc08f37983059eb174076f51f29baada0f749d2de339abb0f"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "f84be297b1f1820872ecc648676bbeec9d872330cdfb86bf272ed039a208bd3b" => :catalina
    sha256 "f79c8d58afbf0b0ea423aa3b03d126ca226330df391384d01b222b9d6f88ec3c" => :x86_64_linux
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
