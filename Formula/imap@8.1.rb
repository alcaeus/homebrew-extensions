# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4317da35d36150d2b876861ae48038477dfebe70.tar.gz?commit=4317da35d36150d2b876861ae48038477dfebe70"
  version "8.1.0"
  sha256 "15faa2d4dcb3a3ee6605d2ddff6beecb63e0c86de10e9e90aa41588c42be363f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256 cellar: :any, arm64_big_sur: "cc5904c2eaf12137c11f9aa4588b9d77f41d81f52a780d6e6b8c821947b76cb2"
    sha256 cellar: :any, big_sur:       "6c0495f19963fb1975b95b596ed8f8603ae2b745201f35d4bda88172b94bdcdb"
    sha256 cellar: :any, catalina:      "c1355ab26b148ceb0663d766d8eaa55ce13a10a6613de531f839eb15211b20e5"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
