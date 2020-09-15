class Horcrux < Formula
  desc "Split your file into encrypted fragments"
  homepage "https://github.com/jesseduffield/horcrux"
  url "https://github.com/jesseduffield/horcrux.git",
    tag:      "v0.3",
    revision: "17a9719f3b589f0cb4350a87ffa75ccdad974ab2"
  license "MIT"
  head "https://github.com/jesseduffield/horcrux.git"

  bottle do
    root_url "https://github.com/dawidd6/homebrew-tap/releases/download/horcrux-0.3"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ee44e058f80e1053a35a705b5fab341935ade74cafc118f18ba79c60bf193126" => :catalina
    sha256 "7c075c631e438f3b866efaba3b3580da0b5fcfa8931b39d3e0720d0e1fd1a937" => :x86_64_linux
  end

  depends_on "go" => :build

  patch do
    url "https://github.com/jesseduffield/horcrux/commit/e3d73706ce7967490cdf0da60a0a423544fe4e54.patch?full_index=1"
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
    mv "diary.txt", "diary.txt.o"
    system bin/"horcrux", "bind"
    assert_equal (testpath/"diary.txt").read, (testpath/"diary.txt.o").read
  end
end
