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
      nushell
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
      gh
      mysql-client # mysql cli client
      flyway # db migrations
      parallel
      xsv
      file # file type guesser
      which
      tree
      gnused
      gnutar
      gawk
      zstd # Zstandard real-time compression algorithm
      gnupg # GNU Privacy Guard

      nix-output-monitor # it provides the command `nom` works just like `nix` with more details log output

      # productivity
      glow # markdown previewer in terminal
      btop # replacement of htop/nmon

      python3

      # dotnet
      (
        with dotnetCorePackages;
          combinePackages [
            sdk_9_0
            sdk_8_0
            sdk_6_0
          ]
      )

      # golang
      go
      gotestsum
      golangci-lint

      # node
      nodejs_23
      yarn

      # lisp
      clisp
      # clasp-common-lisp # broken LLVM version
    ]
    ++ unstable_packages;
}
