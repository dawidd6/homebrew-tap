class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"
  url "https://github.com/containers/podman/archive/v4.2.1.tar.gz"
  sha256 "b10004e91a9f5528da450466ec8e6f623eaa28ada79e3044c238895b2c8d1df3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/podman-4.2.1"
    rebuild 3
    sha256 x86_64_linux: "2a452746546c447cc4ed02ff801fb4e3fadf4012c0532afc2585b54131c9a18f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "conmon"
  depends_on "crun"
  depends_on "fuse-overlayfs"
  depends_on "gpgme"
  depends_on "libseccomp"
  depends_on :linux
  depends_on "slirp4netns"
  depends_on "systemd"

  resource "storage.conf" do
    url "https://src.fedoraproject.org/rpms/containers-common/raw/23d18a07d33c4db77905a38a77278c7a499ee097/f/storage.conf"
    sha256 "c426db62a5dd5e5af54f3b4608cbc4da2ef682f0a6b02d9cb9000c1231df48dc"
  end

  resource "catatonit" do
    url "https://github.com/openSUSE/catatonit/archive/refs/tags/v0.1.7.tar.gz"
    sha256 "e22bc72ebc23762dad8f5d2ed9d5ab1aaad567bdd54422f1d1da775277a93296"

    # Fix autogen.sh. Delete on next release.
    patch do
      url "https://github.com/openSUSE/catatonit/commit/99bb9048f532257f3a2c3856cfa19fe957ab6cec.patch?full_index=1"
      sha256 "cc0828569e930ae648e53b647a7d779b1363bbb9dcbd8852eb1cd02279cdbe6c"
    end
  end

  resource "netavark" do
    url "https://github.com/containers/netavark/archive/refs/tags/v1.2.0.tar.gz"
    sha256 "35b710197f321a2e45c59460fd8faf67b7b8ebc345d22aa8ecccf806790c6edc"
  end

  resource "aardvark-dns" do
    url "https://github.com/containers/aardvark-dns/archive/refs/tags/v1.2.0.tar.gz"
    sha256 "434163027660feebb87e288d9c9f8468a1a9d1a632d1f9fe0a84585dfde3f4dd"
  end

  # Patch to fix "podman run --rm" hanging on stopping the container.
  patch :DATA

  def install
    ENV.O0
    ENV["PREFIX"] = prefix
    ENV["EXTRA_LDFLAGS"] = %W[
      -X github.com/containers/storage/types.defaultConfigFile=#{etc}/containers/storage.conf
      -X github.com/containers/image/v5/signature.systemDefaultPolicyPath=#{etc}/containers/policy.json
      -X github.com/containers/common/pkg/config.additionalHelperBinariesDir=#{libexec}/podman
      -X github.com/containers/common/pkg/config.additionalConmonEnvPath=#{HOMEBREW_PREFIX}/bin
    ].join(" ")
    system "make", "podman", "podman-remote", "rootlessport", "docs"
    system "make", "install.bin", "install.remote", "install.man", "install.completions"
    (etc/"containers").install "test/policy.json"
    (etc/"containers").install resource("storage.conf")
    resource("catatonit").stage do
      system "./autogen.sh"
      system "./configure"
      system "make"
      mv "catatonit", libexec/"podman/"
    end
    resource("netavark").stage do
      system "cargo", "install", *std_cargo_args
      mv bin/"netavark", libexec/"podman/"
    end
    resource("aardvark-dns").stage do
      system "cargo", "install", *std_cargo_args
      mv bin/"aardvark-dns", libexec/"podman/"
    end
  end

  def caveats
    <<~EOS
      Needs newuidmap and newgidmap installed system-wide as root.
    EOS
  end

  service do
    run [opt_bin/"podman", "system", "service", "--time=0"]
    environment_variables PATH: std_service_path_env
    working_dir HOMEBREW_PREFIX
  end

  test do
    # It checks if there are no helper binaries in bindir.
    assert_equal %W[
      #{bin}/podman
      #{bin}/podman-remote
    ].sort, Dir[bin/"*"].sort
    # It checks if all needed helper binaries are present.
    assert_equal %W[
      #{libexec}/podman/catatonit
      #{libexec}/podman/netavark
      #{libexec}/podman/aardvark-dns
      #{libexec}/podman/rootlessport
    ].sort, Dir[libexec/"podman/*"].sort
    # It checks if podman-remote binary could be executed.
    out = shell_output("#{bin}/podman-remote info 2>&1", 125)
    assert_match "Cannot connect to Podman", out
    # Catatonit is an init program run in container.
    # It checks if catatonit is statically linked.
    out = shell_output("file #{libexec}/podman/catatonit")
    assert_match "statically linked", out
    # It checks configured network backend and storage driver.
    out = shell_output("#{bin}/podman system info")
    assert_match "networkBackend: netavark", out
    assert_match "graphDriverName: overlay", out
    # Pull the image earlier so we won't measure the network bandwidth below too.
    # It checks if policy.json file is properly read.
    system bin/"podman", "pull", "docker.io/library/alpine"
    # Below command should be fast.
    # It checks if "podman run --rm" patch is still working.
    system "timeout", "5", bin/"podman", "run", "--rm", "docker.io/library/alpine", "true"
  end
end
__END__
diff --git a/vendor/github.com/containers/common/pkg/config/default.go b/vendor/github.com/containers/common/pkg/config/default.go
index 161a9c8d6..003a3f34e 100644
--- a/vendor/github.com/containers/common/pkg/config/default.go
+++ b/vendor/github.com/containers/common/pkg/config/default.go
@@ -103,6 +103,7 @@ var (
 	// should be set during link-time, if different packagers put their
 	// helper binary in a different location.
 	additionalHelperBinariesDir string
+	additionalConmonEnvPath string
 )
 
 // nolint:unparam
@@ -359,7 +360,7 @@ func defaultConfigFromMemory() (*EngineConfig, error) {
 	c.OCIRuntime = c.findRuntime()
 
 	c.ConmonEnvVars = []string{
-		"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
+		fmt.Sprintf("PATH=%s:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin", additionalConmonEnvPath),
 	}
 	c.ConmonPath = []string{
 		"/usr/libexec/podman/conmon",
