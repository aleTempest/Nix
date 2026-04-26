{
  boot.loader.grub = {
    efiSupport = true;
    device = "nodev";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.initrd.kernelModules = [ "nvidia" "i915" "nvidia_uvm" "nvidia_drm" ];
}
