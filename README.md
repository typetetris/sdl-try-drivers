# sdl-try-drivers

For each reported driver sdl-try-drivers tries to create a renderer
and reports success or failure with the catched exception.

Should build out of the box with stack or cabal.

For nix try

    nix-build shell.nix

and call

    result/bin/sdl-try-drivers
