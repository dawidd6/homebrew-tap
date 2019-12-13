class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.11.tar.gz"
  sha256 "b1c83ee9d19289eb403ad0863c235fa9c3b3a980c9b13a43cda9fc9413935df4"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "317d6d639a6cc29541ec4c66847a7dd39c13ef75cc3163af1ad983b962bf79f6" => :catalina
    sha256 "26b55de92cdc6aef8b15c918be31cc278232c4ffa4ef371c2105f43d800821da" => :x86_64_linux
  end

  uses_from_macos "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "#{name}-#{version}.gem"
    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files libexec/"bin", :GEM_HOME => ENV["GEM_HOME"]
  end

  test do
    system bin/name
  end
end
