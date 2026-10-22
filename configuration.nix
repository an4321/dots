{ config, lib, pkgs, ... }:

{
	imports = [ /etc/nixos/hardware-configuration.nix ];

	nixpkgs.config.allowUnfree = true;

	swapDevices = lib.mkForce [];
	zramSwap.enable = true;
	zramSwap.memoryPercent = 50;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.timeout = 0;

	console = {
		earlySetup = true;
		packages = [ pkgs.terminus_font ];
		font = "ter-v32n";
		keyMap = "us";
	};

	networking.hostName = "nix";
	networking.networkmanager.enable = true;

	time.timeZone = "Asia/Kolkata";
	i18n.defaultLocale = "en_IN";

	users.users."user" = {
		isNormalUser = true;
		description = "user";
		extraGroups = [ "networkmanager" "wheel" "input" "uinput" ];
		shell = pkgs.fish;
	};

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};
	security.rtkit.enable = true;

	programs.hyprland = {
		enable = true;
		withUWSM = true;
	};
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	security.polkit.enable = true;

	services.kanata = {
		enable = true;
		keyboards.internalKeyboard.configFile = ./config/kanata.kbd;
	};

	services.tlp = {
		enable = true;
		settings.START_CHARGE_THRESHOLD_BAT0 = 75;
		settings.STOP_CHARGE_THRESHOLD_BAT0 = 80;
	};

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};
	services.blueman.enable = true;

	services.getty.autologinUser = "user";

	programs.fish.enable = true;
	programs.appimage = {
		enable = true;
		binfmt = true;
	};

	fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		auto-optimise-store = true;
	};
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 14d";
	};

	hardware.graphics.enable = true;
	system.stateVersion = "26.05";
}
