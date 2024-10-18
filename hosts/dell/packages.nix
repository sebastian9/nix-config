# Packages that should be installed to the user profile.
{
  config,
  pkgs,
  ...
}: let
  unstable_packages = with pkgs.unstable; [
  ];
in {
  home.packages = with pkgs;
    [
      neofetch # fancy system info

      p7zip # archives

      # networking tools
      mtr # A network diagnostic tool
      iperf3 # Tool to measure IP bandwidth using UDP or TCP
      dnsutils # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc # it is a calculator for the IPv4/v6 addresses

      # misc
      file # file type guesser
      which
      tree
      gnused
      gnutar
      gawk

      # apps
      dolphin # KDE GUI file manager
      photoqt # Image viewer
      vscode.fhs

      nix-output-monitor # it provides the command `nom` works just like `nix` with more details log output

      # productivity
      glow # markdown previewer in terminal

      btop # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files

      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb

      python3
    ]
    ++ unstable_packages;
}
