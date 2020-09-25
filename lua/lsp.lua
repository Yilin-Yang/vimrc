local nvim_lsp = require'nvim_lsp'
local configs = require'nvim_lsp/configs'

nvim_lsp.clangd.setup{
  settings = {
    name = 'clangd';
    cmd = { "clangd", "--background-index" };
    filetypes = { "c", "cpp", "cc", "objc", "objcpp" };
  }
}

configs.lemminx = {
  default_config = {
    cmd = { "java", "-jar", "/home/yiliny/vimrc/org.eclipse.lemminx-uber.jar" };
    filetypes = { "xml" };
    root_dir = function(fname)
      return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    settings = {}
  };
}

nvim_lsp.lemminx.setup{
  settings = {
    name = "lemminx";
  }
}
