# 1-localization
# Localization & Fonts

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
  i18n.defaultLocale = "de_DE.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
