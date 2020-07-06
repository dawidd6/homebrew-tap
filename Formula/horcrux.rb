class Horcrux < Formula
  desc "Split your file into encrypted fragments"
  homepage "https://github.com/jesseduffield/horcrux"
  url "https://github.com/jesseduffield/horcrux.git",
    :tag      => "v0.3",
    :revision => "17a9719f3b589f0cb4350a87ffa75ccdad974ab2"
  license "MIT"
  head "https://github.com/jesseduffield/horcrux.git"

  depends_on "go" => :build

  patch do
    url "https://github.com/jesseduffield/horcrux/pull/9.patch?full_index=1"
    sha256 "4d5b38176e666b9ebfacbed5fa56321252236bd8c82f0fd4823bca8af0a26569"
  end

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"diary.txt").write <<~EOS
      example
    EOS
    system bin/"horcrux", "-t", "3", "-n", "5", "split", "diary.txt"
    mv "diary.txt", "diary.txt.orig"
    system bin/"horcrux", "bind"
    assert_equal File.read("diary.txt"), File.read("diary.txt.orig")
  end
end
