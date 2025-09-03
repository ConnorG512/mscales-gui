{
  description = "Mscales GUI flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in 
  {
    devShells.${system}.default = pkgs.mkShell {
    buildInputs = with pkgs; [
      zig_0_15
      lldb
      git
      xorg.libX11
      libGL
    ];

    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
      xorg.libX11
      libGL
    ]);

    shellHook = ''
    echo "Entering shell..."
    '';
   };
  };
}
