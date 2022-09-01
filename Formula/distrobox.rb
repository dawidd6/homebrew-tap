class Distrobox < Formula
  desc "Use any linux distribution inside your terminal"
  homepage "https://distrobox.privatedns.org/"
  url "https://github.com/89luca89/distrobox/archive/refs/tags/1.3.1.tar.gz"
  sha256 "22b6625ca243f55c08630d37015cdbfbe1939516022bfef502aa6603f42b4d00"
  license "GPL-3.0"
  head "https://github.com/89luca89/distrobox.git"

  depends_on :linux

  def install
    system "./install.sh", "--prefix", prefix
  end

  test do
    system bin/"distrobox-create", "--dry-run"
  end
end
