{
  description = "oom-hardware";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs: 
  let
    inherit (self) outputs ;
    pkgs = import nixpkgs;
    lib = pkgs.lib;
  in {
    nixosModules = {
      uconsole = (import ./uconsole) {inherit nixos-hardware pkgs lib;};
      deskpi = (import ./deskpi) ;
      cm4 = (import ./cm4);
    };
  };
}