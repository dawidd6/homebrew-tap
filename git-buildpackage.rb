class GitBuildpackage < Formula
  include Language::Python::Virtualenv

  desc " Suite to help with Debian (and RPM) packages in Git repositories"
  homepage "https://honk.sigxcpu.org/piki/projects/git-buildpackage/"
  url "https://github.com/agx/git-buildpackage/archive/debian/0.9.14.tar.gz"
  sha256 "4cf5a5673259930710a31bcd463f9bed6119b4921120eb7089c3cbc193fa787b"

  depends_on "python"
  depends_on "git"

  resource "dateutil" do
    url "https://files.pythonhosted.org/packages/ad/99/5b2e99737edeb28c71bcbec5b5dda19d0d9ef3ca3e92e3e925e7c0bb364c/python-dateutil-2.8.0.tar.gz"
    sha256 "c89805f6f4d64db21ed966fda138f8a5ed7a4fdbc1a8ee329ce1b74e3c74da9e"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end


  def install
    virtualenv_install_with_resources
  end

  test do
    system "gbp --version"
  end
end
