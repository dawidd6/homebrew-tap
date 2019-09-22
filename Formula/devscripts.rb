class Devscripts < Formula
  desc "Scripts to make the life of a Debian maintainer easier"
  homepage "https://salsa.debian.org/debian/devscripts"
  url "https://deb.debian.org/debian/pool/main/d/devscripts/devscripts_2.19.6.tar.xz"
  sha256 "3196092bd274db9aa1e34e68a0c94c6edb49a481dded1656fd9785831bfdcec4"

  def scripts
    %w[
      uscan
      wnpp-check
      rmadison
    ]
  end

  depends_on "perl" => :build
  depends_on "dpkg"

  patch do
    url "https://gist.githubusercontent.com/dawidd6/1d295844f148c7bcdae93c37a2851282/raw/901764a254a9cf80fa81e9ec607eb0f9f44d4ba4/devscripts.patch"
    sha256 "62e7387dd5bbcba355d908eff27f4698c81fd11d02d9d1acb8155d4a83231dee"
  end

  resource "String-ShellQuote" do
    url "https://cpan.metacpan.org/authors/id/R/RO/ROSCH/String-ShellQuote-1.04.tar.gz"
    sha256 "e606365038ce20d646d255c805effdd32f86475f18d43ca75455b00e4d86dd35"
  end

  resource "File-HomeDir" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/File-HomeDir-1.004.tar.gz"
    sha256 "45f67e2bb5e60a7970d080e8f02079732e5a8dfc0c7c3cbdb29abfb3f9f791ad"
  end

  resource "Class-XSAccessor" do
    url "https://cpan.metacpan.org/authors/id/S/SM/SMUELLER/Class-XSAccessor-1.19.tar.gz"
    sha256 "99c56b395f1239af19901f2feeb125d9ecb4e351a0d80daa9529211a4700a6f2"
  end

  resource "Class-Method-Modifiers" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Class-Method-Modifiers-2.13.tar.gz"
    sha256 "ab5807f71018a842de6b7a4826d6c1f24b8d5b09fcce5005a3309cf6ea40fd63"
  end

  resource "Import-Into" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Import-Into-1.002005.tar.gz"
    sha256 "bd9e77a3fb662b40b43b18d3280cd352edf9fad8d94283e518181cc1ce9f0567"
  end

  resource "Params-Classify" do
    url "https://cpan.metacpan.org/authors/id/Z/ZE/ZEFRAM/Params-Classify-0.015.tar.gz"
    sha256 "398ec15cd899fcd8bef3db9ea1748bf631f15f6c32be203e475b67df510a5914"
  end

  resource "Devel-CallChecker" do
    url "https://cpan.metacpan.org/authors/id/Z/ZE/ZEFRAM/Devel-CallChecker-0.008.tar.gz"
    sha256 "5d584e0bf55942517fbb13bea5bff0bdf0d0287c0912030e853fa028a69011dc"
  end

  resource "B-Hooks-OP-Check" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/B-Hooks-OP-Check-0.22.tar.gz"
    sha256 "c7b5d1bef59ef9087ff67eb3168d2624be94ae5464469e259ad11bfb8ad8cdcd"
  end

  resource "DynaLoader-Functions" do
    url "https://cpan.metacpan.org/authors/id/Z/ZE/ZEFRAM/DynaLoader-Functions-0.003.tar.gz"
    sha256 "3eb2347214bce796ffad8d57e29b206094f0557446aeba4f8b334920121ea183"
  end

  resource "Role-Tiny" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Role-Tiny-2.000008.tar.gz"
    sha256 "b1541fc5e3e0eb2dbd55b25c432293c197e0153c2c9f7747deba4df72c27146a"
  end

  resource "strictures" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/strictures-2.000006.tar.gz"
    sha256 "09d57974a6d1b2380c802870fed471108f51170da81458e2751859f2714f8d57"
  end

  resource "Sub-Name" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Sub-Name-0.21.tar.gz"
    sha256 "bd32e9dee07047c10ae474c9f17d458b6e9885a6db69474c7a494ccc34c27117"
  end

  resource "Sub-Quote" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Sub-Quote-2.006003.tar.gz"
    sha256 "be1f3a6f773f351f203cdc8f614803ac492b77d15fd68d5b1f0cd3884be18176"
  end

  resource "Sub-Exporter" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Sub-Exporter-0.987.tar.gz"
    sha256 "543cb2e803ab913d44272c7da6a70bb62c19e467f3b12aaac4c9523259b083d6"
  end

  resource "Sub-Install" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Sub-Install-0.928.tar.gz"
    sha256 "61e567a7679588887b7b86d427bc476ea6d77fffe7e0d17d640f89007d98ef0f"
  end

  resource "Test-Fatal" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Test-Fatal-0.014.tar.gz"
    sha256 "bcdcef5c7b2790a187ebca810b0a08221a63256062cfab3c3b98685d91d1cbb0"
  end

  resource "Try-Tiny" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.30.tar.gz"
    sha256 "da5bd0d5c903519bbf10bb9ba0cb7bcac0563882bcfe4503aee3fb143eddef6b"
  end

  resource "Data-OptList" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Data-OptList-0.110.tar.gz"
    sha256 "366117cb2966473f2559f2f4575ff6ae69e84c69a0f30a0773e1b51a457ef5c3"
  end

  resource "Params-Util" do
    url "https://cpan.metacpan.org/authors/id/A/AD/ADAMK/Params-Util-1.07.tar.gz"
    sha256 "30f1ec3f2cf9ff66ae96f973333f23c5f558915bb6266881eac7423f52d7c76c"
  end

  resource "Scope-Guard" do
    url "https://cpan.metacpan.org/authors/id/C/CH/CHOCOLATE/Scope-Guard-0.21.tar.gz"
    sha256 "8c9b1bea5c56448e2c3fadc65d05be9e4690a3823a80f39d2f10fdd8f777d278"
  end

  resource "File-Which" do
    url "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/File-Which-1.23.tar.gz"
    sha256 "b79dc2244b2d97b6f27167fc3b7799ef61a179040f3abd76ce1e0a3b0bc4e078"
  end

  resource "libwww-perl" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/libwww-perl-6.39.tar.gz"
    sha256 "9a8d7747938aa75d7d524c71574ae7f99ca66a5dac8255a7f7759f373e7774d5"
  end

  resource "Moo" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Moo-2.003004.tar.gz"
    sha256 "f8bbb625f8e963eabe05cff9048fdd72bdd26777404ff2c40bc690f558be91e1"
  end

  resource "Module-Runtime" do
    url "https://cpan.metacpan.org/authors/id/Z/ZE/ZEFRAM/Module-Runtime-0.016.tar.gz"
    sha256 "68302ec646833547d410be28e09676db75006f4aa58a11f3bdb44ffe99f0f024"
  end

  resource "Devel-GlobalDestruction" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Devel-GlobalDestruction-0.14.tar.gz"
    sha256 "34b8a5f29991311468fe6913cadaba75fd5d2b0b3ee3bb41fe5b53efab9154ab"
  end

  resource "Sub-Exporter-Progressive" do
    url "https://cpan.metacpan.org/authors/id/F/FR/FREW/Sub-Exporter-Progressive-0.001013.tar.gz"
    sha256 "d535b7954d64da1ac1305b1fadf98202769e3599376854b2ced90c382beac056"
  end

  resource "ExtUtils-Depends" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-Depends-0.8000.tar.gz"
    sha256 "780ff72128c04c2a22e6801187aa9c58cab298407f6e9d062706af1c250bbe98"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"
    ENV.prepend_path "PERL5LIB", Formula["dpkg"].opt_libexec/"lib/perl5"

    resource("Class-XSAccessor").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Class-Method-Modifiers").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Import-Into").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Params-Classify").stage do
      system "perl", "Build.PL"
      system "./Build"
      system "./Build", "install"
    end

    resource("Devel-CallChecker").stage do
      system "perl", "Build.PL"
      system "./Build"
      system "./Build", "install"
    end

    resource("ExtUtils-Depends").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("B-Hooks-OP-Check").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("DynaLoader-Functions").stage do
      system "perl", "Build.PL"
      system "./Build"
      system "./Build", "install"
    end

    resource("Role-Tiny").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("strictures").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Sub-Name").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Sub-Quote").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Sub-Exporter").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Sub-Install").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Test-Fatal").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Try-Tiny").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Data-OptList").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Params-Util").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Scope-Guard").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("File-Which").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("libwww-perl").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Moo").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Module-Runtime").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Devel-GlobalDestruction").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("Sub-Exporter-Progressive").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("File-HomeDir").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("String-ShellQuote").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    cd "scripts" do
      system "make", "scripts"
      scripts.each do |script|
        bin.install script
      end
    end

    (libexec/"lib/perl5").install "lib/Devscripts"
    bin.env_script_all_files(libexec/"bin", :PERL5LIB => ENV["PERL5LIB"])
  end

  def caveats; <<~EOS
    Only scripts are installed, no docs.
    Currently only these scripts are installed: #{scripts.join(", ")}
  EOS
  end

  test do
    scripts.each do |script|
      system bin/script, "--help"
    end
  end
end
# Build bottle
