class Neofetch < Formula
  desc "Fast, highly customisable system info script"
  homepage "https://github.com/dylanaraps/neofetch"
  url "https://github.com/dylanaraps/neofetch/archive/6.1.0.tar.gz"
  sha256 "ece351e35286b64d362000d409b27597fcbdcf77e8e60fa0adae1f29d3c29637"
  head "https://github.com/dylanaraps/neofetch.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    rebuild 3
    sha256 "7abf103cf5cf73ccf9a71ce668cd0341b7dddcee325f48087cc1cba07e3fff7f" => :mojave
    sha256 "cf931db43c2d3ff38e2b395a94e14e02ac90eb93444a94d8c8a288b1ae577fa5" => :x86_64_linux
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/neofetch", "--config", "none", "--color_blocks", "off",
                              "--disable", "wm", "de", "term", "gpu"
  end
end
# Build
# Build
