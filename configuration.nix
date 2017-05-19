# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget vim firefox atom dmenu chromium git gnome3.gnome_terminal sakura
    keybase go emacs clang python3

    # not quite ready: kbfs ifps

    # unfree
    minecraft steam
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;


  services.xserver = {
  # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    xrandrHeads = [ "LVDS1" "HDMI1" ];

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  #  windowManager.xmonad.extraPackages = self: [ self.xmonadContrib ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.a = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  # doesn't work
  # environment.variables = { GOPATH = "/home/a/go"; };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
