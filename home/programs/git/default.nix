{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager  = "diff-so-fancy | less --tabs=4 -RFX";
    };
    merge.tool = "vimdiff";
    mergetool = {
      cmd    = "nvim -f -c \"Gvdiffsplit!\" \"$MERGED\"";
      prompt = false;
    };
    pull.rebase = false;
  };
in
{
  programs.git = {
    enable = true;
    aliases = {
      amend = "commit --amend -m";
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
    };
    extraConfig = gitConfig;
    ignores = [
      "*.bloop"
      "*.metals"
      "*.metals.sbt"
      "*metals.sbt"
      "*.direnv"
      "*.envrc" # there is lorri, nix-direnv & simple direnv; let people decide
      "*hie.yaml" # ghcide files
      "*.mill-version" # used by metals
    ];
    signing = {
      key = "121D4302A64B2261";
      signByDefault = false;
    };
    userEmail = "dev@juliusblank.de";
    userName = "Julius Blank";
  };
}
