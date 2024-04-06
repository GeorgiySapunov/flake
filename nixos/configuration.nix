# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Moscow";
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.georgiy = {
    isNormalUser = true;
    description = "georgiy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # shell utils
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    tmux
    wget
    git
    gnupg
    gnumake
    killall
    rsync
    moreutils
    fzf
    zoxide
    eza
    lm_sensors
    yt-dlp
    tldr
    stow
    neofetch
    outils
    #
    ncdu
    testdisk
    htop
    btop
    # tmate
    # cmake
    # for archives
    atool
    zip
    unzip
    p7zip
    # for gnome
    gnomeExtensions.caffeine
    # gnomeExtensions.tophat
    gnomeExtensions.gsconnect
    gnomeExtensions.primary-input-on-lockscreen
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.windownavigator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.color-picker
    gnome.gnome-tweaks
    gnome.gnome-software
    gnome.eog
    gnome.gnome-boxes
    gnome-secrets
    keepassxc
    deja-dup
    rhythmbox
    newsflash
    qbittorrent
    junction
    metadata-cleaner
    mousai # Identify any songs in seconds
    networkmanagerapplet # NetworkManager control applet for GNOME (nm-connection-editor)
    usbutils # Tools for working with USB devices, such as lsusb
    #
    ffmpeg
    imagemagick
    libheif
    mpv
    vlc
    syncplay
    libbluray
    libaacs
    inkscape
    gimp
    # libreoffice
    brave
    librewolf
    chromium
    tor-browser-bundle-bin
    blender
    telegram-desktop
    anki
    system-config-printer
    remmina
    okular
    libsForQt5.kdenlive
    glaxnimate # for kdenlive
    # for gramps
    gramps
    osm-gps-map # Used to show maps in the geography view (Gramps)
    (python3.withPackages(ps: with ps; [
      pandas
      matplotlib
      seaborn
      scikit-learn
      tensorflow
      pyyaml
      pyvisa pyvisa-py
      scikit-rf
      pyfiglet
      rich # Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal
      click # Command Line Interface Creation Kit
      icecream # never use print() to debug again.
      setuptools # Packaging and distributing projects
      hydra-core
      requests
      tkinter
      pyicu # Improves localised sorting in Gramps
      debugpy # (DAP for doom emacs)
      isort # py-isort requires isort (doom emacs)
      pyflakes # pyimport requires Python’s module pyflakes (doom emacs)
      pytest nose # run tests (doom emacs)
      # jupyter
      # openai-whisper
    ]))
    pipreqs # allows you to automatically generate the requirements.txt file for your project
    nodePackages.pyright # LSP integration
    black # auto-format
    emacsPackages.consult-flyspell
    emacsPackages.vterm
    emacsPackages.pdf-tools
    emacsPackages.org-pdftools
    # emacsPackages.telega
    pandoc
    languagetool
    zotero
    fd
    ripgrep
    # for geary
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.ru
    aspellDicts.fr
    evolution
    thunderbird
    # Chinese and Japanese
    ibus-engines.libpinyin
    ibus-engines.rime
    # ibus-engines.mozc
    # LaTeX
    texlive.combined.scheme-full
    zathura
    pdftk # to work with pdf
    poppler_utils # A PDF rendering library
    # # ai
    ollama
    openai-whisper
    tesseract
    ocrfeeder
 ];

  i18n.inputMethod = {
    # enabled = "fcitx5";
    # fcitx5.addons = with pkgs; [
    #   fcitx5-rime
    #   fcitx5-chinese-addons
    # ];

    # 我现在用 ibus
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      rime
      # mozc
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services = {
    syncthing = {
        enable = true;
        user = "georgiy";
        dataDir = "/home/georgiy/Documents";    # Default folder for new synced folders
        configDir = "/home/georgiy/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
      };
  };

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs.kdeconnect.enable = true;

  # Using bindfs for font support in flatpack
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [
        #libsForQt5.breeze-qt5  # for plasma
        gnome.gnome-themes-extra
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      source-han-sans
      source-han-serif
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      open-sans
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  ### clean system
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  services.flatpak.enable = true;
  # sudo flatpak remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub

  services.emacs.enable = true;

  virtualisation.docker.enable = true;

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
          /run/current-system "$systemConfig"
    '';
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # load `lib` into namespace at the file head with `{ config, pkgs, lib, ... }:`
  nix.settings = {
    # substituters = lib.mkForce [
    substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=30"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://nix-community.cachix.org"
    ];

    # trusted-users = ["root" "@wheel"];
    # # List of binary cache URLs that non-root users can use
    # trusted-substituters = [
    # ];
    # trusted-public-keys = [
    #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    # ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
