{
  programs.nixvim = {
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
			updatetime = 100;

      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      autoindent = true;


      ignorecase = true;
      smartcase = true;

      cursorline = false;
      cursorcolumn = false;
      signcolumn = "no";
      colorcolumn = "110";

			fileencoding = "utf-8";
    };
  };
}
