class SpotifyLinux < Formula
  desc "Music streaming service"
  homepage "https://spotify.com"
  url "https://repository-origin.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.1.72.439.gc253025e_amd64.deb"
  version "1.1.72.439.gc253025e"
  sha256 "c211a16b6ed6627c4b7d8ca6997376f8345dca638938696933c5495405ce9e16"
  license :cannot_represent

  livecheck do
    url "https://repository-origin.spotify.com/dists/stable/non-free/binary-amd64/Packages"
    regex(/Version: [0-9]:(\d+(?:\.\d+)+\.?[a-z0-9]*)/i)
  end

  depends_on arch: :x86_64
  depends_on :linux

  def install
    system "ar", "x", stable.downloader.basename
    system "tar", "xzf", "data.tar.gz"
    prefix.install "usr/share"
    bin.install_symlink share/"spotify/spotify"
    inreplace share/"spotify/spotify.desktop" do |s|
      s.gsub! "Exec=spotify", "Exec=#{bin}/spotify"
    end
  end

  def post_install
    Dir[share/"spotify/icons/spotify-linux-*.png"].each do |file|
      size = File.basename(file, ".png").split("-").last
      system "xdg-icon-resource", "install", "--noupdate", "--size", size, file, "spotify-client"
    end
    system "xdg-icon-resource", "forceupdate"
    system "xdg-desktop-menu", "install", "--novendor", share/"spotify/spotify.desktop"
    system "xdg-desktop-menu", "forceupdate"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spotify --version")
  end
end
