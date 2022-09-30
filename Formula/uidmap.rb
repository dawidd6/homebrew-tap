class Uidmap < Formula
  desc "Programs to help use subuids"
  homepage "https://github.com/shadow-maint/shadow"
  url "https://github.com/shadow-maint/shadow/releases/download/4.12.3/shadow-4.12.3.tar.xz"
  sha256 "3d3ec447cfdd11ab5f0486ebc47d15718349d13fea41fc8584568bc118083ccd"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/uidmap-4.12.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dfa6f63286f7bd0467ba0bb20392fda549b09bb978145355c25169803acb69f6"
  end

  depends_on "libxcrypt"
  depends_on :linux

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "DESTDIR=#{buildpath}/out", "install"
    bin.install "out/#{bin}/getsubids"
    bin.install "out/#{bin}/newuidmap"
    bin.install "out/#{bin}/newgidmap"
    lib.install Dir["out/#{lib}/*"]
  end

  test do
    user = shell_output("whoami").chomp
    assert_match user, shell_output("#{bin}/getsubids #{user}")
  end
end
