{
  description = "i have no idea how this works";

  inputs = {
    # Package sources.
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";

    # Channel to follow.
    home-manager.inputs.nixpkgs.follows = "unstable";
    nixpkgs.follows = "unstable";
  };
}