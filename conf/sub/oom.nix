{ config, lib, pkgs, ... }:

with lib;

let
  # OOM: max 1000, min -1000. the higher the faster killed
  list = [
    { proc = "telegram-desktop"; score = 1000; }
    { proc = "chrome"; score = 990; }
    { proc = "firefox"; score = 980; }
    { proc = "atom"; score = 970; }
  ];

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
    startAt = "60s";

    serviceConfig = {
      ExecStart = "${oomadj}/bin/oomadj";
    };
  };

  environment.systemPackages = [
    oomadj
  ];
}
