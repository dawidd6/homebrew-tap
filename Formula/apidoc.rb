require "language/node"

class Apidoc < Formula
  desc "RESTful web API Documentation Generator."
  homepage "https://apidocjs.com"
  url "https://github.com/apidoc/apidoc/archive/0.20.1.tar.gz"
  sha256 "078e352cd4a62f64fc6ca5985f7ca2a74100a9f604fc50e1586de0076b7962d3"

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
