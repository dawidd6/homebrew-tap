class ActionsUpdater < Formula
  desc "Updater of used Github Actions in workflow files"
  homepage "https://github.com/dawidd6/actions-updater"
  url "https://github.com/dawidd6/actions-updater/archive/v0.1.15.tar.gz"
  sha256 "e415ab6bb8547d2571d1dd80c686531d21f191e8f080f351355891b1bf96075f"
  license "MIT"
  revision 2
  head "https://github.com/dawidd6/actions-updater.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/actions-updater-0.1.15_2"
    cellar :any_skip_relocation
    sha256 "6be7e3d1b7127500e2f4a5ebceed4c6b3228b740819a6ce4698519cac34a76fb" => :catalina
    sha256 "10fcb0061da5abb59fb06100331fbc80e3940a9c096fe464d48501bdc1bae9b0" => :x86_64_linux
  end

  uses_from_macos "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "#{name}-#{version}.gem"
    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files libexec/"bin", GEM_HOME: ENV["GEM_HOME"]
  end

  test do
    system bin/name
  end
end
