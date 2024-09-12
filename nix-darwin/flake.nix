{
  description = "Mac system flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs}:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages =
        [ 
          pkgs.neovim
          pkgs.direnv
          pkgs.age
          pkgs.sshs
          pkgs.atac
          pkgs.glow
          pkgs.obsidian
        ];
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;  # default shell on catalina
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";
      security.pam.enableSudoTouchIdAuth = true;

      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        # loginwindow.LoginwindowText = "rodrigo";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 120;
      };

      # Homebrew needs to be installed on its own!
      homebrew.enable = true;
      homebrew.casks = [
        "google-chrome"
      ];
      homebrew.brews = [
	      "imagemagick"
      ];
    };
}
