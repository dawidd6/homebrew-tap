class GitBuildpackage < Formula
  include Language::Python::Virtualenv

  desc "Suite to help with Debian (and RPM) packages in Git repos"
  homepage "https://honk.sigxcpu.org/piki/projects/git-buildpackage/"
  url "https://github.com/agx/git-buildpackage.git",
      tag:      "debian/0.9.20",
      revision: "719254dcf01a475d5fd2d4d0e91b5726323bb93f"
  license "GPL-2.0"
  revision 2
  head "https://github.com/agx/git-buildpackage.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/git-buildpackage-0.9.20_2"
    cellar :any_skip_relocation
    sha256 "5fe9d4fb67c5ecac82fefc0fa48b1b06e0742d90de8a82de35565984c9047bad" => :big_sur
    sha256 "cc13f83b186c230051573dd5fa07a4b0125417a14d9b6e2ba102d2ae18363eea" => :catalina
    sha256 "5dd9e548c09fc35f3960da00160de3a948196bf4e8cce51736dacfdcfa0daba6" => :x86_64_linux
  end

  depends_on "pristine-tar"
  depends_on "python@3.9"

  on_macos do
    depends_on "dpkg"
  end

  resource "dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz"
    sha256 "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    v = shell_output "#{bin}/gbp --version"
    assert_match "gbp #{version}", v
  end
end
