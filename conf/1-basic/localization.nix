# 1-localization
# Localization & Fonts

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Select internationalisation properties.
  console = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
  };
  i18n.defaultLocale = "de_DE.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
