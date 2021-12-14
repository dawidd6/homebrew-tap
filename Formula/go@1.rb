class GoAT1 < Formula
  desc "Go compiler 1.x (includes beta, alpha and rc releases)"
  homepage "https://golang.org"
  url "https://dl.google.com/go/go1.17.5.src.tar.gz"
  sha256 "3defb9a09bed042403195e872dcbc8c6fae1485963332279668ec52e80a95a2d"
  license "BSD-3-Clause"

  livecheck do
    url "https://golang.org/dl"
    regex(/go(([0-9.]+)((beta|rc|alpha)[1-9])?)\.src/i)
  end

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/go@1-1.17.4"
    sha256 big_sur:      "6aa84b5bcdf16b9aa4a644a3b865fd08b3a3e37a1651f0fbf669f2d874a3fd08"
    sha256 catalina:     "386f533df67b65928d034d6c29ab86b42299de7e6b338b88dd5ba1e932889fcf"
    sha256 x86_64_linux: "2c18a6f6d64f99b83ca1af16f8266ec8afbe2a63913e2ea1485cae848e72745b"
  end

  keg_only :versioned_formula

  resource "gobootstrap" do
    on_macos do
      if Hardware::CPU.arm?
        url "https://storage.googleapis.com/golang/go1.16.darwin-arm64.tar.gz"
        version "1.16"
        sha256 "4dac57c00168d30bbd02d95131d5de9ca88e04f2c5a29a404576f30ae9b54810"
      else
        url "https://storage.googleapis.com/golang/go1.16.darwin-amd64.tar.gz"
        version "1.16"
        sha256 "6000a9522975d116bf76044967d7e69e04e982e9625330d9a539a8b45395f9a8"
      end
    end

    on_linux do
      url "https://storage.googleapis.com/golang/go1.16.linux-amd64.tar.gz"
      version "1.16"
      sha256 "013a489ebb3e24ef3d915abe5b94c3286c070dfe0818d5bca8108f1d6e8440d2"
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

    # Remove useless files.
    # Breaks patchelf because folder contains weird debug/test files
    rm_rf Dir[libexec/"src/debug/elf/testdata"]
    # Binaries built for an incompatible architecture
    rm_rf Dir[libexec/"src/runtime/pprof/testdata"]
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

    ENV["GOOS"] = "freebsd"
    ENV["GOARCH"] = "amd64"
    system bin/"go", "build", "hello.go"
  end
end
