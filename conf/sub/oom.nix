list:
{ config, lib, pkgs, ... }:

with lib;

let
  cmds = forEach list (iter: escapeShellArgs [ "adj" iter.proc iter.score ]);

  oomadj = pkgs.writeShellScriptBin "oomadj" ''

set -e

adj() {
  p="$1"
  s="$2"
  for pid in $(${pkgs.procps}/bin/pgrep $p); do
    echo "$s" > "/proc/$pid/oom_score_adj"
  done
}

${builtins.concatStringsSep "\n" cmds}

'';
in
{
  imports = [];

  # OOM
  services.earlyoom = {
    enable = true;
    notificationsCommand = "sudo -u maciej DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'OOM TIME' 'the goat has been sacraficed'";
    useKernelOOMKiller = true;
    # ragemode=on
    freeMemThreshold = 20;
    freeSwapThreshold = 60;
  };

  # set oom scores

  systemd.services.oomadj = rec {
    description = "Run oom score adj";
    startAt = "minutely";

    serviceConfig = {
      ExecStart = "${oomadj}/bin/oomadj";
    };
  };

  environment.systemPackages = [
    oomadj
  ];
}
