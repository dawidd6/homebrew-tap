class GoAT1 < Formula
  desc "Go compiler 1.x (includes beta, alpha and rc releases)"
  homepage "https://golang.org"
  url "https://dl.google.com/go/go1.17.3.src.tar.gz"
  sha256 "705c64251e5b25d5d55ede1039c6aa22bea40a7a931d14c370339853643c3df0"
  license "BSD-3-Clause"

  livecheck do
    url "https://golang.org/dl"
    regex(/go(([0-9.]+)((beta|rc|alpha)[1-9])?)\.src/i)
  end

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/go@1-1.17.3"
    sha256 big_sur:      "7aee9034acfd42d77bbe384e5a325faf0bd03ad224bbac84c54051ede4c859bb"
    sha256 catalina:     "1d10b034fe7060568e1d89acde0f22dc3cfcda0fc155a25e0c0341aaa50382f5"
    sha256 x86_64_linux: "b7401b38c514ed4cdd398378c8f6cc99749afa9ccb2040402b8581d8274e2d67"
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
