class GoAT1 < Formula
  desc "Go compiler 1.x (includes beta, alpha and rc releases)"
  homepage "https://golang.org"
  url "https://dl.google.com/go/go1.15.6.src.tar.gz"
  sha256 "890bba73c5e2b19ffb1180e385ea225059eb008eb91b694875dd86ea48675817"
  license "BSD-3-Clause"

  livecheck do
    url "https://golang.org/dl"
    regex(/go(([0-9.]+)((beta|rc|alpha)[1-9])?)\.src/i)
  end

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/go@1-1.15.6"
    sha256 "f221b35f4b3fd763f89e88d7fb33abefd6e5a40e0a1907d05bd150a7b2759e86" => :big_sur
    sha256 "0828aa6d3e288b513a9bd9b343f4f4849e11435e9d9dc3137dd4d8fa7f9fe3e9" => :catalina
    sha256 "6443a4dae746632d57a7432059c23e068184a467a5487559a7111f6b8688a0a2" => :x86_64_linux
  end

  keg_only :versioned_formula

  resource "gotools" do
    url "https://go.googlesource.com/tools.git",
        branch: "master"
  end

  # Don't update this unless this version cannot bootstrap the new version.
  resource "gobootstrap" do
    on_macos do
      url "https://storage.googleapis.com/golang/go1.7.darwin-amd64.tar.gz"
      sha256 "51d905e0b43b3d0ed41aaf23e19001ab4bc3f96c3ca134b48f7892485fc52961"
    end

    on_linux do
      url "https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz"
      sha256 "702ad90f705365227e902b42d91dd1a40e48ca7f67a2f4b2fd052aaa4295cd95"
    end
  end

  def install
    (buildpath/"gobootstrap").install resource("gobootstrap")
    ENV["GOROOT_BOOTSTRAP"] = buildpath/"gobootstrap"

    cd "src" do
      ENV["GOROOT_FINAL"] = libexec
      system "./make.bash", "--no-clean"
    end

    (buildpath/"pkg/obj").rmtree
    rm_rf "gobootstrap" # Bootstrap not required beyond compile.
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/go*"]

    system bin/"go", "install", "-race", "std"

    # Build and install godoc
    ENV.prepend_path "PATH", bin
    ENV["GOPATH"] = buildpath
    (buildpath/"src/golang.org/x/tools").install resource("gotools")
    cd "src/golang.org/x/tools/cmd/godoc/" do
      system "go", "build"
      (libexec/"bin").install "godoc"
    end
    bin.install_symlink libexec/"bin/godoc"
  end

  test do
    (testpath/"hello.go").write <<~EOS
      package main

      import "fmt"

      func main() {
          fmt.Println("Hello World")
      }
    EOS
    # Run go fmt check for no errors then run the program.
    # This is a a bare minimum of go working as it uses fmt, build, and run.
    system bin/"go", "fmt", "hello.go"
    assert_equal "Hello World\n", shell_output("#{bin}/go run hello.go")

    # godoc was installed
    assert_predicate libexec/"bin/godoc", :exist?
    assert_predicate libexec/"bin/godoc", :executable?

    ENV["GOOS"] = "freebsd"
    ENV["GOARCH"] = "amd64"
    system bin/"go", "build", "hello.go"
  end
end
