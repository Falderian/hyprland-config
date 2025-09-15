# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 5;
  #boot.loader = {
  #  efi = {
  #    canTouchEfiVariables = true;
  #  };
  #  grub = {
  #     enable = true;
  #     useOSProber = true;
  #     efiSupport = true;
  #     device = "nodev";
  #     configurationLimit = 5;
  #  };
  #};


  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "pcie_aspm=off" "amdgpu.aspm=0"];

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Minsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
#  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;
#  services.xserver.displayManager.gdm.wayland = true;

  services = {
#    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  # Configure keymap in X11
 services.xserver.xkb = {
   layout = "us";
   variant = "";
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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
    	openvpn3
	    spotify
    	telegram-desktop
    	slack
    	nodejs_24
    	pharo
    	git
      vscodium  
      viber
      google-chrome

     	# hyprland
      foot
     	waybar
    	hyprpaper
    	hyprshot
      hyprsunset
    	pulsemixer
    	wf-recorder
      celluloid
    	swaynotificationcenter
    	starship
    	btop-rocm
    	yazi
    	capitaine-cursors
    	rofi-wayland
    	bluetuith
    	playerctl
    	wl-clipboard
    	marwaita-red
      zafiro-icons
      bash-completion
      wl-clip-persist
      nwg-look
      gurk-rs
    ];
  };

  services.resolved.enable = true;
  programs.openvpn3.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.starship.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "admin";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.variables = {
	  GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";
  };

  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  hardware.bluetooth = {
    enable = true;
	  powerOnBoot = true;
    settings = {
      General = {
    	  Experimental = true; # Show battery charge of Bluetooth devices
	    };
	  };
  };

  environment.etc."nanorc".text = ''
    set tabsize 2
    set tabstospaces
  '';

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
  
  programs.bash.shellAliases = {
    start-vpn="openvpn3 session-start --config ~/Projects/Synchrony/client.ovpn";
    start-synchrony="(cd ~/Projects/Synchrony/ui && npm run start:standalone) & (cd ~/Projects/Synchrony/IMS/Pharo11_dev && pharo --headless smt-base.image --script ../resources_project/SMT/scripts/start-analytics-server.st -- workspace=IMS) & wait";
  };

# programs.vscode = {
#    enable = true;
#    package = pkgs.vscodium;
#    extensions = with pkgs.vscode-extensions; [
#    esbenp.prettier-vscode
#    mhutchie.git-graph
#    ];
#    userSettings = {
#      "editor.fontFamily" = "Liberation Mono";
#      "editor.fontS3ize" = 14;      
#      "editor.formatOnSave" = true;
#    };
#  };
  
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
