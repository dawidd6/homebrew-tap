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
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/git-buildpackage-0.9.20_1"
    cellar :any_skip_relocation
    sha256 "80a718c095b2d633e9e4d3d0d9c1561dd6677392152a86b7795b44185f23e15c" => :catalina
    sha256 "4619d5249fdebf7eecf0c9cd970aba419b5026f670c728e7b660af73d5f3af8d" => :x86_64_linux
  end

  depends_on "pristine-tar"
  depends_on "python@3.9"

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
