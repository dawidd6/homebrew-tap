class Neofetch < Formula
  desc "Fast, highly customisable system info script"
  homepage "https://github.com/dylanaraps/neofetch"
  url "https://github.com/dylanaraps/neofetch/archive/6.1.0.tar.gz"
  sha256 "ece351e35286b64d362000d409b27597fcbdcf77e8e60fa0adae1f29d3c29637"
  head "https://github.com/dylanaraps/neofetch.git"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "3bb8c0495b9071d6e8b39da40db3b5c10f8ba436689004814e4fcd91b8dc8e9c" => :catalina
    sha256 "0b24df44ce92645bf7953f00dda89d8093cd2848ded610a7805a91ac8513f286" => :x86_64_linux
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/neofetch", "--config", "none", "--color_blocks", "off",
                              "--disable", "wm", "de", "term", "gpu"
  end
end
