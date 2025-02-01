{
  description = "oom-hardware";

  outputs = {...}: {
    nixosModules = {
      uconsole = import ./uconsole;
      deskpi = import ./deskpi;
      cm4 = import ./cm4;
    };
  };
}
