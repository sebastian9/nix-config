_: {
  programs.nixvim.plugins = {
    # bunch of classic libraries
    mini = {
      enable = true;
      modules = {
        # gc + *motion* to comment line
        comment = {};
        # hunk editting
        diff = {};
        # highlight all matching words
        cursorword = {};
        # file navigation and directory edits
        files = {};
        # quotes parens etc pairs
        pairs = {};
        # sa + *motion* + *char* to surround words with *char*
        surround = {};
        # show and remove trailing spaces; highlighting doesn't work
        trailspace = {};
        # lightweight notifications :)
        notify = {};
      };
    };
  };
}
