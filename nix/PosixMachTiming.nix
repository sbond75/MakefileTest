# Based on https://gist.github.com/taktoa/51af642c37292e6b15d3bd30c4f9c6ff

{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "PosixMachTiming";
  version = "821e22a2e976f5e8bc9151259df9ba32d619e619";
  src = fetchFromGitHub {
    owner  = "ChisholmKyle";
    repo   = "PosixMachTiming";
    rev    = "821e22a2e976f5e8bc9151259df9ba32d619e619";
    sha256 = "04090zjifnl6zxmymh1g62ks0jk90bmxbia88aa7pimgnc41k0gf";
  };
  buildInputs = [];

  buildPhase = ''
    cc -std=c99 -c src/timing_mach.c -o timing_mach.o
    ar rcs libPosixMachTiming.a timing_mach.o
  '';

  installPhase = ''
    mkdir $out
    mkdir $out/lib
    mkdir $out/include
    mkdir $out/include/PosixMachTiming
    cp -a libPosixMachTiming.a $out/lib
    cp -a src/timing_mach.h $out/include/PosixMachTiming
  '';
}
