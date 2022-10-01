class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"
  url "https://github.com/containers/podman/archive/v4.2.1.tar.gz"
  sha256 "b10004e91a9f5528da450466ec8e6f623eaa28ada79e3044c238895b2c8d1df3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/podman-4.2.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, x86_64_linux: "96239403e91973a70ec9a6fc547273ca985ec5fa1ae184d4925cab4e7b96f8ce"
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
    ENV["PREFIX"] = prefix
    system "make", "podman", "podman-remote", "rootlessport", "docs"
    system "make", "install.bin", "install.remote", "install.man", "install.completions"
    (etc/"containers").install "test/policy.json"
    (etc/"containers").install "test/registries.conf"
  end

  def caveats
    <<~EOS
      Needs newuidmap and newgidmap installed system-wide as root.
    EOS
  end

  test do
    out = shell_output("#{bin}/podman run --rm docker.io/library/alpine true 2>&1", 125)
    assert_match "is not a shared mount", out
    assert_match "this could cause issues or missing mounts with rootless containers", out
  end
end
