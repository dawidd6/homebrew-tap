class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.10.tar.gz"
  sha256 "704cd7b21646a2031fd98d709a287f2c435f3ac65ef9e62f0009d982d74277fe"
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "cc64a987d921d6467c388c00d6033d1a24df18abdce588447c6e30b7cb76d2fa" => :catalina
    sha256 "602984ad54120156f8406cda4302bbd353e318ddc7b57f6032a51cbdc08c8be4" => :x86_64_linux
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
