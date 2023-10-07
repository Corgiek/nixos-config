{ lib, pkgs, inputs, ... }: {

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi"
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 12d";
    };
    optimise.automatic = true;
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Minsk";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.corg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "adbusers" "libvirtd" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  security.polkit.enable = true;

  security.sudo.enable = true;

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    linuxPackages_latest.cpupower
    openssl
    pulsemixer
    htop
    hyfetch
    wayland
    xdg-utils
    glib # gsettings
    gnome3.adwaita-icon-theme
    wl-clipboard
    neovim
    wget
    man-pages
    man-pages-posix
    tmux
    git
    nodejs
    home-manager
    libnotify
    appimage-run
    unzip
    mpv
    ripgrep
    python3
  ];

  fonts.packages = with pkgs; [
    material-design-icons
    phospor
    inter
    dosis
    material-symbols
    rubik
    ibm-plex
    roboto
    (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
  ];

  virtualisation = {
    podman.enable = true;
    docker.enable = true;
    libvirtd.enable = true;
  };

  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}