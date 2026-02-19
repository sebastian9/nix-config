{config, ...}: {
  home.file.".claude/statusline-command.sh" = {
    source = ./claude/statusline-command.sh;
    executable = true;
  };

  home.file.".claude/settings.json" = {
    text = builtins.toJSON {
      permissions = {
        allow = ["mcp__jira__JiraQuery"];
        defaultMode = "default";
      };
      model = "claude-opus-4-6[1m]";
      statusLine = {
        type = "command";
        command = "${config.home.homeDirectory}/.claude/statusline-command.sh";
      };
      enabledPlugins = {
        "csharp-lsp@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
        "pyright-lsp@claude-plugins-official" = true;
      };
      env = {
        CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
      };
      spinnerVerbs = {
        mode = "replace";
        verbs = [
          "Whispering to Powerwalls"
          "Commissioning Megablocks"
          "Convincing Autobidder"
          "Herding electrons"
          "Flattening the duck curve"
          "Annoying gas peakers"
          "Hoarding photons"
          "Tickling lithium ions"
          "Negotiating with ERCOT"
          "Pleasing the ISO"
          "Summoning stored energy"
          "Deploying Megapacks"
          "Teaching batteries to share"
          "Soaking in the sun"
          "Outrunning thermal runaway"
          "Making utilities nervous"
          "Hiding from duck curves"
          "Smuggling megawatts"
          "Intimidating inverters"
          "Confusing the Gateway"
          "Channeling Elon energy"
          "Plotting utility obsolescence"
          "Speedrunning decarbonization"
          "Achieving peak arbitrage"
          "Outsmarting gas plants"
          "Convincing the sun to cooperate"
          "Waking up the Powerpacks"
          "Calming the frequency"
          "Blaming the clouds"
          "Rebooting the grid"
          "Questioning round-trip efficiency"
          "Overthrowing fossil fuels"
          "Flexing on the duck curve"
          "Charging aggressively"
          "Discharging strategically"
          "Winning the capacity auction"
          "Confusing PG&E"
          "Making electrons go brrr"
          "Accelerating sustainable energy"
        ];
      };
    };
  };
}
