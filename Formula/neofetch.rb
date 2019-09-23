class Neofetch < Formula
  desc "Fast, highly customisable system info script"
  homepage "https://github.com/dylanaraps/neofetch"
  url "https://github.com/dylanaraps/neofetch/archive/6.1.0.tar.gz"
  sha256 "ece351e35286b64d362000d409b27597fcbdcf77e8e60fa0adae1f29d3c29637"
  head "https://github.com/dylanaraps/neofetch.git"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "9a378b8d63a93c6cc05f93d05eee1400575e893793ec19740cf02e1e4e0d6eed" => :x86_64_linux
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/neofetch", "--config", "none", "--color_blocks", "off",
                              "--disable", "wm", "de", "term", "gpu"
  end
end
