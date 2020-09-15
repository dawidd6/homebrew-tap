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
    rebuild 1
    sha256 "8733c684af6c6bb099c7c71c3fd2d9878212476d94e77fa840e8b5d1e2737ccb" => :catalina
    sha256 "ffcad3e22b69dfa60653b6cfb01ec66c5f753d3324d1053b4a13e0bb06febb9b" => :x86_64_linux
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
    system bin/"actions-updater"
  end
end
