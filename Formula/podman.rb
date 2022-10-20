class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"
  url "https://github.com/containers/podman/archive/v4.3.0.tar.gz"
  sha256 "55a3a09b80f23f78aaeb74fbf878fa0b1ef1842e5b282ad61e82a9dc4c74bf34"
  license all_of: ["Apache-2.0", "GPL-3.0-or-later"]

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/podman-4.3.0"
    sha256 x86_64_linux: "a3c4c96e0db2e902a3dfac545a9969e35d0dfe52541630c644b2a08e19acad29"
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

  def install
    paths = Dir["**/*.go"].select do |file|
      (buildpath/file).read.lines.grep(%r{/etc/containers/}).any?
    end
    inreplace paths, "/etc/containers/", etc/"containers/"

    ENV.O0
    ENV["PREFIX"] = prefix
    ENV["HELPER_BINARIES_DIR"] = opt_libexec/"podman"

    system "make"
    system "make", "install", "install.completions"

    (prefix/"etc/containers/policy.json").write <<~EOS
      {"default":[{"type":"insecureAcceptAnything"}]}
    EOS

    (prefix/"etc/containers/storage.conf").write <<~EOS
      [storage]
      driver="overlay"
    EOS

    (prefix/"etc/containers/registries.conf").write <<~EOS
      unqualified-search-registries=["docker.io"]
    EOS

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
      You need "newuidmap" and "newgidmap" binaries installed system-wide
      for rootless containers to work properly.
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
    # It checks if registries.conf is recognized.
    system bin/"podman", "pull", "alpine"
    # Below command should be fast.
    # It checks if containers.conf is properly filled (conmon_env_vars).
    system "timeout", "5", bin/"podman", "run", "--rm", "alpine", "true"
  end
end
