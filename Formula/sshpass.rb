class Sshpass < Formula
  desc "Non-interactive ssh password authentication"
  homepage "https://sourceforge.net/projects/sshpass"
  url "https://downloads.sourceforge.net/project/sshpass/sshpass/1.09/sshpass-1.09.tar.gz"
  sha256 "71746e5e057ffe9b00b44ac40453bf47091930cba96bbea8dc48717dedc49fb7"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/sshpass-1.09"
    sha256 cellar: :any_skip_relocation, monterey:     "60f59752799a65593b48d052d9fc629ba25ba60fb12d0175f04afc1e8b6ffd4f"
    sha256 cellar: :any_skip_relocation, big_sur:      "c2bbe08d8a200c840c34697a6728c1f1a098f1fdc7b131dd31910151ddeb15b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "67482d6afccf9b1cb17dd39ee9d9bae7deb1f3ad53e3ca81ae1882311b006f98"
  end

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "sshpass"
  end
end
