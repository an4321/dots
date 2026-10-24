{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		home-manager.url = "github:nix-community/home-manager/release-26.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
	let
		system = "x86_64-linux";
		pkgsUnstable = import nixpkgs-unstable {
			inherit system;
			config.allowUnfree = true;
		};
	in {
		nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit pkgsUnstable; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.user = import ./home.nix;
					home-manager.backupFileExtension = "backup";

					home-manager.extraSpecialArgs = {
						inherit pkgsUnstable;
					};
				}
			];
		};
	};
}
