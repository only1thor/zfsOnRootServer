{ pkgs, ... }: {
  # configuration in this file only applies to zfsOnRootServer host.
  programs.tmux = {
    enable = true;
    newSession = true;
    terminal = "tmux-direct";
  };
  services.emacs.enable = false;
}
