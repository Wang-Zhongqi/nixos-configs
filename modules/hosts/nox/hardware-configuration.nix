{ self, inputs, ... }: {
  flake.nixosModules.noxHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/e9594e53-3aaf-4306-871a-7ee9f4a93d96";
        fsType = "btrfs";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/e9594e53-3aaf-4306-871a-7ee9f4a93d96";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/e9594e53-3aaf-4306-871a-7ee9f4a93d96";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/EAB7-B8E3";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/d5c06108-d7ed-4e7e-ba74-fea45e4df78f"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
