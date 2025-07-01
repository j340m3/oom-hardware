{
  description = "oom-hardware";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware
  } : 
  let
    inherit (self) outputs;
  in {
    nixosModules = {
      uconsole = import ./uconsole;
      deskpi = import ./deskpi ;
      cm4 = import ./cm4;
    };
  };
}