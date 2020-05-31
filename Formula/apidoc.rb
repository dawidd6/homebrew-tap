require "language/node"

class Apidoc < Formula
  desc "RESTful web API Documentation Generator"
  homepage "https://apidocjs.com"
  url "https://github.com/apidoc/apidoc/archive/0.23.0.tar.gz"
  sha256 "d20884f85b2cccb212cd39b473b9272eeb512935e5258cb00650b40468a66e5c"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "32003f83fdf89bfc1e067e4d5e8632d28d5c416e8e1f68dcab8845c483896ace" => :catalina
    sha256 "609f7d5e4fc5b0852cccc3acc6b74b27917b1a391ebed9851c14ffc99523c484" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"api.go").write <<~EOS
      /**
       * @api {get} /user/:id Request User information
       * @apiName GetUser
       * @apiGroup User
       *
       * @apiParam {Number} id User's unique ID.
       *
       * @apiSuccess {String} firstname Firstname of the User.
       * @apiSuccess {String} lastname  Lastname of the User.
       */
    EOS
    system bin/"apidoc", "-o", "out"
  end
end
