class GitBuildpackage < Formula
  include Language::Python::Virtualenv

  desc "Suite to help with Debian (and RPM) packages in Git repos"
  homepage "https://honk.sigxcpu.org/piki/projects/git-buildpackage/"
  url "https://github.com/agx/git-buildpackage.git",
      tag:      "debian/0.9.21",
      revision: "30bcbe28112180c4c11265597ec357095f7ba99d"
  license "GPL-2.0"
  head "https://github.com/agx/git-buildpackage.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/git-buildpackage-0.9.21"
    sha256 cellar: :any_skip_relocation, big_sur:      "585a9d79db56917f5a98b608c8bf3eb228ae1c0b9f281add9a53a9c61f969b1d"
    sha256 cellar: :any_skip_relocation, catalina:     "365b67fe4e104e39e3e7fe23138e762f0ff1914f8700d7e64de22e84e0eceb59"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5075abecf382ec90ef757bf64901681e2bc578fe517ff8ad504fb68cfd88e056"
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
