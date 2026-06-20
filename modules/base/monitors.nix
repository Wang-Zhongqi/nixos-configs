{
  flake.nixosModules.monitors = { lib, ... }: {
    options.monitors = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              example = "DP-1";
            };
            mode = lib.mkOption {
              type = lib.types.str;
              default = "prefered";
            };
            x = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            y = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            scale = lib.mkOption {
              type = lib.types.float;
              example = "default";
            };
            bitdepth = lib.mkOption {
              type = lib.types.int;
              default = 8;
            };
            transform = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;
            };
          };
        }
      );
      default = [ ];
    };
  };
}
