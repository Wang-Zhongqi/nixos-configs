{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri.enable = true;
    programs.niri.package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia)
          ];
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          outputs = {
            "DP-4" = {
              position = _: {
                props = {
                  x = 0;
                  y = 250;
                };
              };
              scale = 1.5;
              focus-at-startup = { };
            };
            "DP-1" = {
              position = _: {
                props = {
                  x = 2560;
                  y = 0;
                };
              };
              scale = 1.67;
              transform = "270";
            };
          };

          input.keyboard.xkb.layout = "cn";
          layout.gaps = 5;
          binds = {
            "Mod+Q".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+E".spawn-sh = lib.getExe pkgs.kdePackages.dolphin;
            "Mod+R".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
            "Mod+T".toggle-window-floating = { };

            "Mod+C".close-window = { };
            "Mod+B".spawn-sh = lib.getExe pkgs.firefox;
            "Mod+M".show-hotkey-overlay = { };

            "Mod+Left".focus-column-left = { };
            "Mod+Right".focus-column-right = { };

            "Mod+F".maximize-column = { };
            "Mod+Shift+F".fullscreen-window = { };

            "Mod+S".spawn-sh =
              "${lib.getExe pkgs.grim} -g \"\$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe pkgs.satty} -f -";
          };

          window-rules = [
            {
              matches = [
                {
                  app-id = "satty";
                }
              ];
              open-floating = true;
            }
          ];
        };
      };
    };
}
