class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"
  url "https://github.com/containers/podman/archive/v4.2.1.tar.gz"
  sha256 "b10004e91a9f5528da450466ec8e6f623eaa28ada79e3044c238895b2c8d1df3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/podman-4.2.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "871b99aa71ea5f264dae3fa416b07a285c32128688791848e2aac58ab41b9fff"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "pkg-config" => :build
  depends_on "conmon"
  depends_on "crun"
  depends_on "fuse-overlayfs"
  depends_on "gpgme"
  depends_on "libseccomp"
  depends_on :linux
  depends_on "slirp4netns"
  depends_on "systemd"

  def install
    ENV.O0
    # ENV["BUILDTAGS"] = "exclude_graphdriver_devicemapper exclude_graphdriver_btrfs seccomp systemd"
    ENV["PREFIX"] = prefix
    system "make", "podman", "podman-remote", "rootlessport", "docs"
    system "make", "install.bin", "install.remote", "install.man", "install.completions"
  end

  test do
    assert_match "is not a shared mount", shell_output("#{bin}/podman run --rm docker.io/library/alpine true 2>&1", 125)
  end
end
