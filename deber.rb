class Deber < Formula
  desc "Debian packaging with Docker"
  homepage "https://github.com/dawidd6/deber"
  version "0.5"
  url "#{homepage}/archive/#{version}.tar.gz"
  sha256 "77838bdcbcb4b37a395314d3679a2a9fd0fd0c7909cee3a277bc50c8816b8839"
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{buildpath}/go"
    system "go", "build", "-v", "-o", "#{bin}/#{name}"
  end

  test do
    system "#{bin}/#{name}", "--version"
  end
end
