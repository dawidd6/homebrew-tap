class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"
  url "https://github.com/containers/podman/archive/v4.2.1.tar.gz"
  sha256 "b10004e91a9f5528da450466ec8e6f623eaa28ada79e3044c238895b2c8d1df3"
  license "Apache-2.0"

  depends_on "go-md2man" => :build
  # Required latest gvisor.dev/gvisor/pkg/gohacks
  # Try to switch to the latest go on the next release
  depends_on "go@1.18" => :build
  depends_on "pkg-config" => :build
  depends_on "gpgme"
  depends_on :linux

  def install
    ENV["PREFIX"] = prefix
    system "make", "build-no-cgo"
    system "make", "install.bin", "install.remote", "install.man", "install.completions"
  end

  test do
    system bin/"podman", "run", "--rm", "docker.io/library/alpine", "true"
  end
end
