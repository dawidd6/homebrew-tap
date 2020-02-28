class GitBuildpackage < Formula
  include Language::Python::Virtualenv

  desc "Suite to help with Debian (and RPM) packages in Git repos"
  homepage "https://honk.sigxcpu.org/piki/projects/git-buildpackage/"
  url "https://github.com/agx/git-buildpackage.git",
      :tag      => "debian/0.9.19",
      :revision => "8f893f9993484c5bf553070a637227a08243e84e"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "58c77b903da84ec8fffce165b71b22b029448cee0e65652fba5887df296ae677" => :catalina
    sha256 "03b5576f60149bc9dfa0ca041c7286e020d131a68864e6476c09c34283b1ef08" => :x86_64_linux
  end

  depends_on "dpkg" => [:build, :test]
  depends_on "pristine-tar"
  depends_on "python"

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
