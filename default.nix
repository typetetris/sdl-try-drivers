{ mkDerivation, base, pretty-simple, sdl2, stdenv, text }:
mkDerivation {
  pname = "sdl-try-drivers";
  version = "0.0.0.1";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base pretty-simple sdl2 text ];
  description = "small testing tool for sdl2 and accelerated drivers";
  license = stdenv.lib.licenses.mit;
}
