{ self, inputs, ... }: {
  perSystem = { pkgs, lib, ... }: {
    packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json));
    };
  };
}