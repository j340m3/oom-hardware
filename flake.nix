{
  description = "oom-hardware";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs : 
  let
    #inherit outputs;
  in {
    nixosModules = {
      uconsole = import ./uconsole;
      deskpi = import ./deskpi ;
      cm4 = import ./cm4;
    };
  };
}