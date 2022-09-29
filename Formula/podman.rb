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

  resource "gvproxy" do
    url "https://github.com/containers/gvisor-tap-vsock/archive/v0.4.0.tar.gz"
    sha256 "896cf02fbabce9583a1bba21e2b384015c0104d634a73a16d2f44552cf84d972"
  end

  def install
    ENV["BUILDTAGS"] = "exclude_graphdriver_btrfs exclude_graphdriver_devicemapper"
    ENV["PREFIX"] = prefix
    system "make", "podman", "docs"
    system "make", "install.bin", "install.man", "install.completions"
  end

  test do
    system bin/"podman"
  end
end
