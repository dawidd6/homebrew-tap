class Forgit < Formula
  desc "Utility tool powered by fzf for using git interactively"
  homepage "https://github.com/wfxr/forgit"
  head "https://github.com/wfxr/forgit.git"

  bottle :unneeded

  depends_on "fzf"

  def install
    share.install Dir["forgit*"]
  end

  def caveats
    <<~EOS
      Place this line in shell config file (choose extension wisely):
        source #{share}/forgit.plugin.{sh,zsh,fish}
    EOS
  end

  test do
    system "bash", "-c", "source #{share}/forgit.plugin.sh && alias ga"
  end
end
