{ pkgs, ...}:

let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
in
  pkgs.writeShellScriptBin "monitor" ''
    monitors=$(${xrandr} --listmonitors)

    if [[ $monitors == *"HDMI-1"* ]]; then
      echo "HDMI-1"
    elif [[ $monitors == *"eDP-1"* ]]; then
      echo "eDP-1"
    elif [[ $monitors == *"DP-1"* ]]; then
      echo "DP-1"
    else
      echo "eDP"
    fi
  ''
