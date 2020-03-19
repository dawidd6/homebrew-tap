class Multipass < Formula
  desc "Multipass orchestrates virtual Ubuntu instances"
  homepage "https://multipass.run"
  url "https://github.com/canonical/multipass.git",
    :tag      => "v1.1.0",
    :revision => "4475d3491f2acd0e849756b8d994717c5d517f10"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "qt"
  depends_on :linux

  patch :DATA

  def install
    system "git", "submodule", "update", "--init", "--recursive", "--force"
    mkdir "build" do
      system "cmake", "..", "-DMULTIPASS_ENABLE_TESTS=off", "-DMULTIPASS_VERSION=#{version}", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index cda9afd..bf67ac9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -137,7 +137,7 @@ function(determine_version OUTPUT_VARIABLE)
   endif()
 endfunction()
 
-determine_version(MULTIPASS_VERSION)
+#determine_version(MULTIPASS_VERSION)
 set(MULTIPASS_VERSION ${MULTIPASS_VERSION})
 message(STATUS "Setting version to: ${MULTIPASS_VERSION}")
 
