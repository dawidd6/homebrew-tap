class VscodeLinux < Formula
  desc "Open-source code editor"
  homepage "https://code.visualstudio.com"
  url "https://packages.microsoft.com/repos/vscode/pool/main/c/code/code_1.66.0-1648620611_amd64.deb"
  version "1.66.0-1648620611"
  sha256 "86f77fd7a022de83b56ff55d4f733ae60b1d196d9b1518e038685dcf3a4c53da"
  license :cannot_represent

  livecheck do
    url "https://packages.microsoft.com/repos/vscode/dists/stable/main/binary-amd64/Packages"
    regex(/Version: (\d+(?:\.\d+)+-[0-9]+)/i)
  end

  depends_on arch: :x86_64
  depends_on :linux

  def install
    system "ar", "x", stable.downloader.basename
    system "tar", "xJf", "data.tar.xz"
    system "tar", "xJf", "control.tar.xz"
    system "cat", "postinst"
    system "tree"
    system "false"
    prefix.install "usr/share"
    bin.install_symlink share/"code/bin/code"
    inreplace share/"applications/code.desktop" do |s|
      s.gsub! "Exec=/usr/share/code/code", "Exec=#{bin}/code"
    end
  end

  def post_install
    Dir[share/"code/icons/code-linux-*.png"].each do |file|
      size = File.basename(file, ".png").split("-").last
      system "xdg-icon-resource", "install", "--noupdate", "--size", size, file, "code"
    end
    system "xdg-icon-resource", "forceupdate"
    system "xdg-desktop-menu", "install", "--novendor", share/"applications/code.desktop"
    system "xdg-desktop-menu", "forceupdate"
  end

  test do
    assert_match version.to_s.split("-").first, shell_output("#{bin}/code --version")
  end
end
