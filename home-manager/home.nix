{ config, pkgs, ... }:

{
  imports = [
      # ./apps/doom.nix
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "georgiy";
  home.homeDirectory = "/home/georgiy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".zshrc".source = dotfiles/zsh/.zshrc;
    ".config/zsh/aliases.zsh".source = dotfiles/zsh/.config/zsh/aliases.zsh;
    ".config/zsh/exports.zsh".source = dotfiles/zsh/.config/zsh/exports.zsh;
    ".config/zsh/.zshrc".source = dotfiles/zsh/.config/zsh/.zshrc;

    ".config/mpv".source = dotfiles/mpv;
    ".config/zathura".source = dotfiles/zathura;
  };

  home.file = {
    ".config/wget/wgetrc".text = ''
       hsts-file=~/.cache/wget-hsts
     '';

    # ".local/bin/gitpullall".text = ''
    #    #!/bin/sh

    #    find . -maxdepth 1 -type d -exec \
    #        test -e '{}/.git' ';' \
    #        -print0 | xargs -I {} -0 \
    #        git -C {} pull
    #  '';

    # ".local/bin/toggle_touchpad.sh".text = ''
    #    #!/usr/bin/env bash

    #    if [ $(gsettings get org.gnome.desktop.peripherals.touchpad send-events) == "'enabled'" ]; then
    #        echo "Switching off"
    #        gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled
    #    else
    #        echo "Switching on"
    #        gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
    #    fi
    #  '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/georgiy/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
