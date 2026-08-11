# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
#     cores = 15;
#     max-jobs = 2;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # cross-comile
  boot.kernelParams = [ "video=HDMI-A-1:1920x1080@75" ]; # remove 2-3s of black screen

  networking.hostName = "labin-703"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zagreb";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hr_HR.UTF-8";
    LC_IDENTIFICATION = "hr_HR.UTF-8";
    LC_MEASUREMENT = "hr_HR.UTF-8";
    LC_MONETARY = "hr_HR.UTF-8";
    LC_NAME = "hr_HR.UTF-8";
    LC_NUMERIC = "hr_HR.UTF-8";
    LC_PAPER = "hr_HR.UTF-8";
    LC_TELEPHONE = "hr_HR.UTF-8";
    LC_TIME = "hr_HR.UTF-8";
  };

  services.xserver.enable = false;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "hr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "croat";

  services.displayManager = {
    plasma-login-manager.enable = true;
    defaultSession = "plasma";
  };
  services.desktopManager.plasma6.enable = true;

  # Firmware updater
  services.fwupd.enable = true;

#   services.iperf3 = {
#     enable = false;
#     openFirewall = true;
#   };


  services.ipp-usb.enable = true;

#   services.avahi = {
#     enable = true;
#     nssmdns4 = true;
#     nssmdns6 = true;
#     openFirewall = true;
#     publish = {
#       enable = true;
#       userServices = true;
#     };
#   };

  services.printing = {
    enable = true;
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
      hplipWithPlugin
    ];
  };

#   services.samba = {
#     enable = true;
#     package = pkgs.sambaFull;
#     openFirewall = true;
#     settings = {
#       "global" = {
#         "load printers" = "yes";
#         "printing" = "cups";
#         "printcap name" = "cups";
#       };
#       "printers" = {
#         "comment" = "All Printers";
#         "path" = "/var/spool/samba";
#         "public" = "yes";
#         "browseable" = "yes";
#         # to allow user 'guest account' to print.
#         "guest ok" = "yes";
#         "writable" = "no";
#         "printable" = "yes";
#         "create mode" = 0700;
#       };
#     };
#   };
#   systemd.tmpfiles.rules = [
#     "d /var/spool/samba 1777 root root -"
#   ];

  # Allow scanning with SANE driver
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
#     netConf = "192.168.1.13";
#     openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

#    extraConfig.pipewire."92-low-latency" = {
#      "context.properties" = {
#        "default.clock.alloweed-rates" = [
#          44100
#          48000
#          88200
#          96000
#          176400
#          192000
#        ];
#        "default.clock.quantum" = 16;
#        "default.clock.min-quantum" = 8;
#        "default.clock.max-quantum" = 16;
#      };
#    };
  };

  # Disable auto-mute on ALSA startup
  systemd.services.alsa-disable-auto-mute = {
    description = "Disable ALSA auto-mute mode";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.alsa-utils}/bin/amixer -c Generic sset 'Auto-Mute Mode' Disabled";
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.romana = {
    isNormalUser = true;
    description = "Romana";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
      "libvirtd"
      "kvm"
      "cdrom"
    ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.filelight
      kdePackages.skanlite
      kdePackages.isoimagewriter
      kdePackages.kdenlive
      kdePackages.kgpg
      kdePackages.plasma-login-manager
      kdePackages.audiocd-kio
      kdePackages.k3b
      osu-lazer-bin
#       betterdiscordctl
      (prismlauncher.override { jdks = [ jdk25 ]; })
#       (lutris.override {
#         extraLibraries = pkgs: [ geckodriver ];
#         extraPkgs = pkgs: [ mangohud ];
#       })
    ];
  };

  # Install steam

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extraCompatPackages = with pkgs; [ proton-ge-bin ]; # Proton GE
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  # Install localsend
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # Install thunderbird
  programs.thunderbird.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    fastfetch
    hyfetch
    keepassxc
    gimp3
#     apktool
#     darktable
#     mpv
    vlc
    libreoffice-qt-fresh
    librewolf
    nicotine-plus
    rnote
#     ani-cli
    vscodium
#     discord
#     signal-desktop
    qbittorrent
#     handbrake
    inkscape-with-extensions
#     jpegoptim
    firefox
#     calibre
#     protonup-qt
    simple-scan
#     killall
    nixfmt
    qdiskinfo
    kdiskmark
#     kicad
#     simavr
    remmina
#     electrum
    scrcpy
    (btop.override { rocmSupport = true; })
    tor-browser
    uefitool
    rpi-imager
    (pkgs.callPackage ../../modules/kate-wakatime.nix { })
    heroic
    vscode-fhs
    rawtherapee
#     anime4k
#     inputs.llamato-nixpkgs.legacyPackages.${pkgs.system}.llvm-mos

    android-tools
    (android-studio.withSdk (androidenv.composeAndroidPackages { platformVersions = [ "36" ]; includeNDK = true; }).androidsdk)
  ];

  # Set up PGP
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
  programs.seahorse.enable = true; # pgp gui

  # Virt-manager
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    spiceUSBRedirection.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      open-sans
      comic-mono
      comic-neue
      freefont_ttf
      arphic-uming
      baekmuk-ttf
    ];
  };


  services.zerotierone = {
    enable = true;
    joinNetworks = [ "743993800f415883" ];
  };

  programs.ssh = {
    extraConfig = ''
      Host tina-server
        User romana
        HostName homelab.llamato.dev
        IdentitiesOnly yes
        IdentityFile ${inputs.secrets.ssh.tina}
      Host openwrt
        User root
        HostName 192.168.1.1
        IdentitiesOnly yes
        IdentityFile ${inputs.secrets.ssh.openwrt}
      Host github.com
        User git
        IdentitiesOnly yes
        IdentityFile ${inputs.secrets.ssh.github}
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
