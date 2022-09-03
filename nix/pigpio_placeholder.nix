# Based on https://gist.github.com/taktoa/51af642c37292e6b15d3bd30c4f9c6ff

{ stdenv, fetchFromGitHub, cmake, callPackage }:

stdenv.mkDerivation {
  pname = "pigpio_placeholder";
  version = "79";
  src = fetchFromGitHub {
    owner  = "joan2937";
    repo   = "pigpio";
    rev    = "c33738a320a3e28824af7807edafda440952c05d";
    sha256 = "0wgcy9jvd659s66khrrp5qlhhy27464d1pildrknpdava19b1r37";
  };
  buildInputs = [cmake
                 ((callPackage ./PosixMachTiming.nix {}).overrideAttrs (oldAttrs: rec {
      patchPhase = (oldAttrs.patchPhase or "") + ''
        ls -la
        substituteInPlace src/timing_mach.h --replace 'inline int clock_nanosleep_abstime ( const struct timespec *req )' 'inline int clock_nanosleep_abstime ( const struct timespec *req, struct timespec *rem )' --replace 'retval = nanosleep ( &ts_delta, NULL );' 'retval = nanosleep ( &ts_delta, rem );'
        substituteInPlace src/timing_mach.c --replace 'extern int clock_nanosleep_abstime (const struct timespec *req);' 'extern int clock_nanosleep_abstime (const struct timespec *req, struct timespec *rem);' --replace 'int retval = clock_nanosleep_abstime(ts_target);' 'int retval = clock_nanosleep_abstime(ts_target, NULL);'
      '';
                 }))
                ];
  patches = [ ./pigpio.patch2.patch ./pigpio_placeholder.patch ];
}

# # Based on https://gist.github.com/taktoa/51af642c37292e6b15d3bd30c4f9c6ff
# 
# { lib, buildPythonPackage, cmake, fetchFromGitHub }:
# 
# buildPythonPackage rec {
#   pname = "pigpio";
#   version = "79";
#   src = fetchFromGitHub {
#     owner  = "joan2937";
#     repo   = "pigpio";
#     rev    = "c33738a320a3e28824af7807edafda440952c05d";
#     sha256 = "0wgcy9jvd659s66khrrp5qlhhy27464d1pildrknpdava19b1r37";
#   };
#   buildInputs = [cmake];
#   patches = [ ./pigpio.patch2.patch ];
# }
# 
