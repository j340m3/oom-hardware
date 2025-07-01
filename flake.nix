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
  }: 
  {
    nixosModules = {
      uconsole = ./uconsole;
      deskpi = ./deskpi;
      cm4 = ./cm4;
    };
  };
}