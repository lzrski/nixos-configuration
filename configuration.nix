# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "macbook-pro-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware = {
    bluetooth.enable = true;

    # https://github.com/nixos-users/wiki/wiki/Bluetooth
    # https://wiki.archlinux.org/index.php/bluetooth
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    facetimehd.enable = false; # We don't want this propriatery crap!
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "pl";
    defaultLocale = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [
    fira-code
  ];

  programs.zsh.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # Basics
    wget
    vim
    httpie
    git
    jq

    # Window manager and related stuff
    i3
    compton
    rofi
    i3blocks
    i3lock
    arandr
    xlibs.xbacklight

    # Development
    atom

    # Various
    vlc
    firefox
    # gnome3.cheese # the only video app that I've had any success with Facetime HD camera, but now it's disabled anyway
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "pl";
    xkbOptions = "eurosign:e";

    synaptics = {
      enable = true;

      # http://who-t.blogspot.fr/2010/11/how-to-ignore-configuration-errors.html
      dev = "/dev/input/event*";
      twoFingerScroll = true;
      accelFactor = "0.001";
      buttonsMap = [ 1 3 2 ];
      tapButtons = false;
      palmDetect = true;
      additionalOptions = ''
        Option "VertScrollDelta" "-180" # scroll sensitivity, the bigger the negative number = less sensitive
        Option "HorizScrollDelta" "-180"
        Option "FingerLow" "40"
        Option "FingerHigh" "70"
        Option "Resolution" "270" # Pointer sensitivity, this is for a retina screen, so you'll probably need to change this for an air
      '';
    };

    # Enable the KDE Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.i3.enable = true;
  };

  virtualisation.lxd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.tadeusz = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "lxd" ];
    shell = pkgs.zsh;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
