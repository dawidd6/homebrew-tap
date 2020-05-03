require "language/node"

class Apidoc < Formula
  desc "RESTful web API Documentation Generator"
  homepage "https://apidocjs.com"
  url "https://github.com/apidoc/apidoc/archive/0.22.1.tar.gz"
  sha256 "51933011af0811f57ed221c96a75a229dbd0f5cfabf6800f2339f50d970919b1"

  bottle do
    root_url "https://dl.bintray.com/dawidd6/bottles-tap"
    cellar :any_skip_relocation
    sha256 "606ed7e0c06e7d50893e6a330f1eed6b0ecf011164fbe1174ea8956c07dc8004" => :catalina
    sha256 "7536f0ddefd3030318e364468d42b9d8c78335cf2be29dc4e0f200a2e2190dad" => :x86_64_linux
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
