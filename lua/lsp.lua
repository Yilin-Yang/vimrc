local lspconfig = require'lspconfig'
local configs = require'lspconfig.configs'

lspconfig.bashls.setup{}

lspconfig.jsonls.setup{}
lspconfig.cssls.setup{}
lspconfig.html.setup{}

lspconfig.vimls.setup{}
lspconfig.pylsp.setup{}

lspconfig.clangd.setup{
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
      return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    settings = {}
  };
}

lspconfig.lemminx.setup{
  settings = {
    name = "lemminx";
  }
}
