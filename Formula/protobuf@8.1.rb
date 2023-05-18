# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Protobuf Extension
class ProtobufAT81 < AbstractPhpExtension
  init
  desc "Protobuf PHP extension"
  homepage "https://github.com/protocolbuffers/protobuf"
  url "https://pecl.php.net/get/protobuf-3.23.1.tgz"
  sha256 "42330d01638c5c62894394b7780166d76ff67c53356ff2528a5afc961b5cd030"
  head "https://github.com/protocolbuffers/protobuf.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b117542a34a067077eda86be53960d05dcca1b97705a6440eb1900ab97eb883"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d2c6f321efcd9bb8760dd48b4ff3dbbfb63384c297a40e43528823270db6c486"
    sha256 cellar: :any_skip_relocation, ventura:        "6a02e8b3fe1175029bb7ac1bb2c3879b0211a3e9079840da76a026ebaa354c65"
    sha256 cellar: :any_skip_relocation, monterey:       "fd8d589dbeac9a07caaa671497a5b2f342482741ff9595572c25c6b986211adf"
    sha256 cellar: :any_skip_relocation, big_sur:        "5b901c3d08dcd0cc1bd87ff42da7ff5bab98f8d6e1ae9ba1d1a04310ee91e287"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d58a3976af490f5bbc22f2260fd391e4425eea714f1df3d1df199418bbabd2ec"
  end

  def install
    Dir.chdir "protobuf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-protobuf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end

  def caveats
    <<~EOS
      Copyright 2008 Google Inc.  All rights reserved.

      Redistribution and use in source and binary forms, with or without
      modification, are permitted provided that the following conditions are
      met:

          * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
          * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following disclaimer
      in the documentation and/or other materials provided with the
      distribution.
          * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
      A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

      Code generated by the Protocol Buffer compiler is owned by the owner
      of the input file used when generating it.  This code is not
      standalone and requires a support library to be linked with it.  This
      support library is itself covered by the above license.

      To finish installing #{extension} for PHP #{php_version}:
        * #{config_filepath} was created,"
          do not forget to remove it upon extension removal."
        * Validate installation by running php -m
    EOS
  end
end
