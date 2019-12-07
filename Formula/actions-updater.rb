class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.9.tar.gz"
  sha256 "03bd078240ff503d4858c57fae915ba4db860e0be9f9b70d7b94159637700353"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "da42e75878654d9f5f4df5fe0fdaa57bdac5f88c5ccbd1cb0ae9b8238e08bd7a" => :catalina
    sha256 "62e41afa4977a9e2af47b297e07684422855b8fe3193b3d44a56684a5ddb3adb" => :x86_64_linux
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
