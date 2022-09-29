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

  # Allow specifying helper dirs with $BINDIR as base directory. Use a `$BINDIR` magic
  # token as a prefix in the helper path to indicate it should be relative to the
  # directory where the binary is located.
  # This patch can be dropped on upgrade to podman 4.3.0.
  patch do
    url "https://github.com/containers/common/commit/030b7518103cfd7b930b54744d4a4510b659fdc2.patch?full_index=1"
    sha256 "7c00abe7728d6438abcdb69ce6efa43503dcbb93bcb2d737f6ca4aa553e2eeb5"
    directory "vendor/github.com/containers/common"
  end

  # Update Darwin config to include '$BINDIR/../libexec/podman' in helper search path.
  # This patch can be dropped on upgrade to podman 4.3.0.
  patch do
    url "https://github.com/containers/common/commit/4e6828877b0067557b435ec8810bda7f5cb48a4f.patch?full_index=1"
    sha256 "01c4c67159f83f636a7b3a6007a010b1336c83246e4fb8c34b67be32fd6c2206"
    directory "vendor/github.com/containers/common"
  end

  def install
    ENV["BUILDTAGS"] = "exclude_graphdriver_btrfs exclude_graphdriver_devicemapper"
    ENV["HELPER_BINARIES_DIR"] = "$$BINDIR/../libexec/podman"
    ENV["PREFIX"] = prefix
    system "make"
    system "make", "install", "install.completions"

    resource("gvproxy").stage do
      system "make", "gvproxy"
      (libexec/"podman").install "bin/gvproxy"
    end
  end

  test do
    system bin/"podman"
  end
end
