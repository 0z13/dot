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

  networking.hostName = "bread"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 



  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;


services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
        defaultSession = "none+i3";
    };

    libinput.enable = true;
    libinput.touchpad = {
        naturalScrolling = true;
	middleEmulation = true;
	tapping = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

  

   nixpkgs.config = {
	allowUnfree = true;
   };

 

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.z = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
  }; environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    chromium
    kitty 
    tmux 
    
    #utils
    ripgrep 
    ccls
    fzf
    git
    curl
    tokei
    exa
    fd
    bat
    bintools
    qemu
    gdb
    gcc
    gnumake
    gdb
    qemu 
    binutils-unwrapped
    coreutils
    gnused
    gnutar
    findutils
    gawk
    rlwrap
    lldb
    valgrind
    clang-tools
    pv
    
    # :/ 
    qbittorrent
    vlc
    discord
    zulip
    calibre
    youtube-dl
    spotify

    
    #
    #langs
    binaryen
    wabt
    gcc
    nodejs
    rustup
    python3
    clang_12
    ghc   
    stack
    lsof 
    openssl
    pkg-config
    yarn
    nodejs


  ];

  #macos cam
  #hardware.facetimehd.enable = true;
 };

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      hack-font
      fira-code
      ubuntu_font_family
      inconsolata
      noto-fonts
      noto-fonts-emoji
      iosevka
      jetbrains-mono
      ];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };



  networking.extraHosts =
    ''
      127.0.0.1 reddit.com
      127.0.0.1 www.reddit.com
      127.0.0.1 old.reddit.com
      127.0.0.1 www.old.reddit.com

      127.0.0.1 news.ycombinator.com
      127.0.0.1 hckrnews.com

      127.0.0.1 lobste.rs
      127.0.0.1 www.lobste.rs

      127.0.0.1 twitter.com
      127.0.0.1 www.twitter.com

      127.0.0.1 facebook.com
      127.0.0.1 www.facebook.com
    '';

}

