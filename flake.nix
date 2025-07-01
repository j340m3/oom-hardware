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
  in {
    nixosModules = {
      uconsole = {
        specialArgs = {inherit inputs outputs;};
        imports = [./uconsole];
      };
      deskpi = import ./deskpi;
      cm4 = import ./cm4;
    };
  };
}