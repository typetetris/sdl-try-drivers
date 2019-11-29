{ mkDerivation, base, pretty-simple, sdl2, stdenv }:
mkDerivation {
  pname = "sdl-try-drivers";
  version = "0.0.0.1";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base pretty-simple sdl2 ];
  description = "small testing tool for sdl2 and accelerated drivers";
  license = stdenv.lib.licenses.mit;
}
