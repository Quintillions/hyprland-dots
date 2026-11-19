{config, pkgs, ...}:
{
  boot = {
    kernelModules = [ "uinput" ];
    
    initrd.kernelModules = [ "amdgpu" ];
    
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      efi.canTouchEfiVariables = true;

    };

    kernelParams = [    
      "video=2560x1440@180"
    ];
    

  };
}