{pkgs, ...}: {
  environment.systemPackages = [pkgs.nginx];
  services.nginx = {
    enable = true;
    virtualHosts = {
      "photo.home" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:2342";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_buffering off;
          '';
        };
      };
    };
  };
}
