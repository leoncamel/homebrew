require 'formula'

class Libusb < Formula
  url 'http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.8/libusb-1.0.8.tar.bz2'
  homepage 'http://www.libusb.org/'
  md5 '37d34e6eaa69a4b645a19ff4ca63ceef'
  head 'git://git.libusb.org/libusb.git'

  def options
    [["--universal", "Build a universal binary."]]
  end

  if ARGV.build_head? and MacOS.xcode_version >= "4.3"
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "./autogen.sh" if ARGV.build_head?
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
