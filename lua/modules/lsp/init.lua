vim.cmd[[packadd nvim-lspconfig]]

local nvim_lsp = require('lspconfig')
local mappings = require('modules.lsp._mappings')

require('modules.lsp._custom_handlers') -- override hover callback
require('modules.lsp._diagnostic') -- diagnostic stuff

local custom_on_attach = function(client)
  mappings.lsp_mappings()

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

local custom_on_init = function()
  print('Language Server Protocol started!')
end

nvim_lsp.tsserver.setup{
  filetypes = { 'javascript', 'typescript', 'typescriptreact' },
  on_attach = function(client)
    mappings.lsp_mappings()

    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end

    client.resolved_capabilities.document_formatting = false
  end,
  on_init = custom_on_init,
  root_dir = function() return vim.loop.cwd() end,
  settings = {
    javascript = {
      suggest = { enable = false },
      validate = { enable = false }
    }
  }
}

nvim_lsp.html.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init
}

nvim_lsp.cssls.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init
}

nvim_lsp.rust_analyzer.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init,
}

nvim_lsp.clangd.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init
}

nvim_lsp.gopls.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  root_dir = function() return vim.loop.cwd() end,
}

local system_name = "Linux"
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

nvim_lsp.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
      completion = { keywordSnippet = "Disable" },
      diagnostics = {
        enable = true,
        globals = {
          "vim", "describe", "it", "before_each", "after_each",
          "awesome", "theme", "client"
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    }
  }
}

nvim_lsp.solargraph.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      commandPath = '/home/francob/.gem/ruby/2.7.0/bin/solargraph',
      diagnostics = true
    },
  },
}


nvim_lsp.pyright.setup{
  on_attach = custom_on_attach,
  on_init = custom_on_init,
}


nvim_lsp.pyls_ms.setup{
  cmd = { "dotnet", "exec", "/home/francob/python-language-server/output/bin/Debug/Microsoft.Python.LanguageServer.dll" },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
}


nvim_lsp.sqlls.setup{
  cmd = {"/usr/local/bin/sql-language-server", "up", "--method", "stdio"},
  on_attach = custom_on_attach,
  on_init = custom_on_init,
}
