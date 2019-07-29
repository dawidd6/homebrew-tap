# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Debutils < Formula
  desc "Useful programs for Debian Developers"
  homepage "https://github.com/dawidd6/debutils"
  head "https://github.com/dawidd6/debutils.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{buildpath}/go"
    system "go", "install", "./..."
    system "mv", "#{ENV["GOPATH"]}/bin", "#{prefix}"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test debutils`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
