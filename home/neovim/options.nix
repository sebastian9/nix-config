_: {
  programs.nixvim.opts = {
    # You can search for any of these using Telescope help_tags

    # Enable mouse
    mouse = "a";

    # Wrap lines
    wrap = true;

    # Line numbers
    number = true;
    relativenumber = true;

    # Tabs and identation
    autoindent = true;
    smartindent = true;
    expandtab = true;
    tabstop = 4;
    softtabstop = 4;

    # Minimum number of lines visible when scrolling up/down
    scrolloff = 8;

    # Enable ignorecase + smartcase for better searching
    ignorecase = true;
    smartcase = true; # Don't ignore case with capitals

    # Set encoding type
    encoding = "utf-8";
    fileencoding = "utf-8";

    # Persist undo history
    undofile = true;
    swapfile = false;
    backup = false;

    # Search behavior
    hlsearch = true;
    incsearch = true;

    # shows the effects of |:substitute|, |:smagic|,
    # |:snomagic| and user commands with the |:command-preview|
    # flag as you type.
    inccommand = "split";

    # We don't need to see things like INSERT anymore
    showmode = false;

    # Faster update time, default 4000
    updatetime = 50;

    # nice visual-block
    virtualedit = "block";

    # Enable the sign column to prevent the screen from jumping
    signcolumn = "yes";
  };
}
