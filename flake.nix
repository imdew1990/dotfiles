{
  description = "Imdew's system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle }:
  let
    configuration = { pkgs, config,  ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages =
        [ 
	pkgs.mkalias
	pkgs.neovim
	pkgs.tmux
	pkgs.aldente
	pkgs.raycast
	pkgs.alacritty
	pkgs.qbittorrent
	pkgs.obsidian
	pkgs.spotify
        ];

	fonts.packages = [
	  pkgs.nerd-fonts.jetbrains-mono
	];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
	programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

     # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      homebrew = {
	enable = true;
	brews = [
	];

	casks = [
	"1password"
	"1password-cli"
	"telegram-desktop"
	"the-unarchiver"
	"protonvpn"
	"firefox"
	"visual-studio-code"
	"discord"
	"docker"
	"winbox"
	"bazecor"
	];

	masApps = {
	  "PixelmatorPro" = 1289583905;
	  "YubikeyAuth" = 1497506650;
	  "Wireguard" = 1451685025;
	};

	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Persons-MacBook-Pro
    darwinConfigurations."Persons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
	configuration 
	nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;

            enableRosetta = false;

            user = "imdew";

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
	      "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };

            mutableTaps = false;
          };
        }
      ];
    };
  };
}
