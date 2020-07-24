class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.15.tar.gz"
  sha256 "e415ab6bb8547d2571d1dd80c686531d21f191e8f080f351355891b1bf96075f"
  license "MIT"
  revision 1
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "4b6e387d23fa28aedb02afb706722e2794baea9170befc55e101922554d7911c" => :catalina
    sha256 "a75e00473e4b2754b364859329260f8d19343b021abfa34136f4a73339e1498d" => :x86_64_linux
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
