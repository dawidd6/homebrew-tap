class GitBuildpackage < Formula
  include Language::Python::Virtualenv

  desc "Suite to help with Debian (and RPM) packages in Git repos"
  homepage "https://honk.sigxcpu.org/piki/projects/git-buildpackage/"
  url "https://github.com/agx/git-buildpackage.git",
      tag:      "debian/0.9.23",
      revision: "ada32de487e500e11b29673377cb31da8bc04225"
  license "GPL-2.0"
  head "https://github.com/agx/git-buildpackage.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/git-buildpackage-0.9.22"
    sha256 cellar: :any_skip_relocation, big_sur:      "b4556ece31ddcafc0ca02c5fc46b8a664519466b824ea13fac2014cb30f837f2"
    sha256 cellar: :any_skip_relocation, catalina:     "0ed0afddcfe72b2a8ca4281d5d272620c820fd2b86b844cc85195381640c06dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ac24c65dd2ab0495ecbae09cd6e820bb6923627a485e11b8198810d9364361b"
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
