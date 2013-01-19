require 'formula'

class Nzbget < Formula
  homepage 'http://sourceforge.net/projects/nzbget/'
  url 'http://downloads.sourceforge.net/project/nzbget/nzbget-stable/9.1/nzbget-9.1.tar.gz'
  sha1 '779258e9349ebc1ea78ae1d7ba5d379af35d4040'
  head 'https://nzbget.svn.sourceforge.net/svnroot/nzbget/trunk', :using => :svn

  # Also depends on libxml2 but the one in OS X is fine
  depends_on 'pkg-config' => :build
  depends_on 'libsigc++'
  depends_on 'libpar2'
  depends_on 'libgcrypt'
  depends_on 'gnutls'

  fails_with :clang do
    build 421
    cause <<-EOS.undent
      Configure errors out when testing the libpar2 headers because
      Clang does not support flexible arrays of non-POD types.
      EOS
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
    system "make install-conf"
  end
end
