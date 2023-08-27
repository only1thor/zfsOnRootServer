# configuration in this file is shared by all hosts

{ pkgs, ... }: {
  # Enable NetworkManager for wireless networking,
  # You can configure networking with "nmtui" command.
  networking.useDHCP = true;
  networking.networkmanager.enable = false;

  users.users = {
    root = {
      initialHashedPassword = "$6$NkKD9a3EUFQlXtYr$wk3NVTfMEmRMqkAfAYUdI723unRLNYo6tXsUeBTNLBp6Ts0sBFNVxRfZkLpZGxLDCMnnm3QuWLlcQoqKTRRjJ/";
      openssh.authorizedKeys.keys = [ 
#        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/43wyhH622OG5DGKTHajpCcg08EpSnvs2ZOPEKloM25zR84zjpwxjR4ptwb9+GMhNbN1v47/qCfcOV8rlbh7A/Ycp9DZuBXFxSS7SPkTOlieawZJYtAW7slGC9p2v/g+hZwKPlVK1FJkBQJMHidvivHnTFGUqggSm6S3rZdCRPIQIhEHQCWM1tEOkgT3Wm4E+QIAKBfXCfvGnMjBvYrBGPzjXYchUy/IGBOJgJaRedmUDxHznuIzzpTRBXh2QNP94MXPeNRKM/cIFkZPSVwB0PhMY33JfGAf3eI+VRsMb+0FSWBGaNRrJpn8+OpxurMXmI+Ce7tyG05NLTz5Oj8sb Thor.ssh" 
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIO4UiQJEr/Jb7ww7wBK4kWHFCK6VaDyCAhDdyqpry0CSAAAABHNzaDo= solokey"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIGUMIs7fAR1lgbFDli+/pQN93AltYiE4DUYvANATlcz8AAAABHNzaDo= Yubikey-C"
      ];
      shell = pkgs.fish;
    };
    tc = {
      isNormalUser = true;
      initialHashedPassword = "$6$mZCP9Rw3GhpLV9O6$SKh5A/0HAWS9k2jrTO7WW9P/qeMdlRedSfAPorLXUaeRtyLoYqcjMNWFmdplebMJ7Lgv9L5zbcJod2pxlB88S."; # yeah that pw
      openssh.authorizedKeys.keys = [ 
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/43wyhH622OG5DGKTHajpCcg08EpSnvs2ZOPEKloM25zR84zjpwxjR4ptwb9+GMhNbN1v47/qCfcOV8rlbh7A/Ycp9DZuBXFxSS7SPkTOlieawZJYtAW7slGC9p2v/g+hZwKPlVK1FJkBQJMHidvivHnTFGUqggSm6S3rZdCRPIQIhEHQCWM1tEOkgT3Wm4E+QIAKBfXCfvGnMjBvYrBGPzjXYchUy/IGBOJgJaRedmUDxHznuIzzpTRBXh2QNP94MXPeNRKM/cIFkZPSVwB0PhMY33JfGAf3eI+VRsMb+0FSWBGaNRrJpn8+OpxurMXmI+Ce7tyG05NLTz5Oj8sb Thor.ssh" 
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAAdMhVgL4b6VdTBp+hDVwnlon5iem30ge+VNSrfKIimmEQxQSbxW1Cn3BnWum7LPKSEk68l3SjHGEi48BOIhkUY0wC/uV/NvRVGBAy5H3r0Dm34wmGMeg7rg+EO39kwA2JOYomxiQA53yhwO0aiozULoe5JLcRuoqV13VTg10Okjs0E/Q== tc@Heimdall"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPehtI6dNVHr2bonqTFwO97I9hxoGI6VaMMDtVn1iJOR root@heimdall"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIO4UiQJEr/Jb7ww7wBK4kWHFCK6VaDyCAhDdyqpry0CSAAAABHNzaDo= solokey"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIGUMIs7fAR1lgbFDli+/pQN93AltYiE4DUYvANATlcz8AAAABHNzaDo= Yubikey-C"
      ];
      shell = pkgs.fish;
            
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  services.tailscale.enable = true;

  # Sanoid service
  services.sanoid = {
    enable = true;
    interval = "hourly";
    datasets."rpool/backup/test" = {
      useTemplate = ["template_backup"];
      recursive = true;
    };
    datasets."rpool/backup/BorgBackedup" = {
      useTemplate = ["template_backup"];
      recursive = true;
    };
  };

  # Sanoid Templates
  services.sanoid.templates.template_backup = {
    frequently = 4;
    hourly = 48;
    daily = 30;
    monthly = 3;
    yearly = 0;
    autosnap = false;
    autoprune = true;
};

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

#  console.keyMap = "dvorak-no";
  services.xserver = {
    enable = true;
    layout = "no";
    xkbVariant = "dvorak";
    xkbOptions = "grp:win_space_toggle";
  };
  console.useXkbConfig = true;

  boot.zfs.forceImportRoot = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.git.enable = true;
  programs.fish.enable = true;

  security = {
    doas.enable = true;
    sudo.enable = false;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      fish
      mg # emacs-like editor
      jq # other programs
      tailscale
    ;
  };
}
