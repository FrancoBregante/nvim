local ts_utils = require "nvim-lsp-ts-utils"

local M = {}

M.plugin = {
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  config = function()
    require("plugins.tsserver").config()
  end,
}

M.config = function()
  local lspconfig = require "lspconfig"

  lspconfig.tsserver.setup {
    filetypes = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
    },
    init_options = {
      documentFormatting = false,
    },
    on_init = Util.lsp_on_init,
    on_attach = function(client)
      require("modules.lsp._mappings").lsp_mappings()

      ts_utils.setup {
        eslint_bin = "eslint_d",
        eslint_args = {
          "-f",
          "json",
          "--stdin",
          "--stdin-filename",
          "$FILENAME",
        },
        eslint_enable_disable_comments = true,
        eslint_enable_diagnostics = true,
        eslint_diagnostics_debounce = 250,
        eslint_config_fallback = vim.fn.stdpath "config" .. "/.eslintrc.js",
      }
      ts_utils.setup_client(client)
    end,
    root_dir = vim.loop.cwd,
  }
end

return M