vim.cmd([[packadd formatter.nvim]])

local k = require("astronauta.keymap")
local nnoremap = k.nnoremap
vim.env.PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath('config') .. "/.prettierrc"

local prettier = function()
  return {
    exe = "prettier",
    args = {
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
    },
    stdin = true,
  }
end

-- local denofmt = function()
--   return {
--     exe   = "deno",
--     args  = { "fmt", "-" },
--     stdin = true,
--   }
-- end

local rubocop = function()
  return {
    exe   = "rubocop",
    args = {
      '-a'
    },
    stdin = true,
  }
end

local rustfmt = function()
  return {
    exe   = "rustfmt",
    args  = { "--emit=stdout" },
    stdin = true,
  }
end

local dartfmt = function()
  return {
    exe = "dartfmt",
    args = { "--fix" },
    stdin = true,
  }
end

local gofmt = function()
  return {
    exe   = "gofumpt",
    stdin = true,
  }
end

local stylua = function()
  return {
    exe = "stylua",
    args = {
      "--config-path",
      "~/.config/nvim/.stylua",
      "-",
    },
    stdin = true,
  }
end

require("formatter").setup({
  logging = true,
  filetype = {
    typescriptreact = { prettier },
    javascriptreact = { prettier },
    javascript = { prettier },
    typescript = { prettier },
    svelte     = { prettier },
    css        = { prettier },
    jsonc      = { prettier },
    json       = { prettier },
    html       = { prettier },
    rust       = { rustfmt },
    ruby       = { rubocop },
    go         = { gofmt },
    lua        = { stylua },
    dart       = { dartfmt },
  },
})

nnoremap({ "<Leader>gf", "<CMD>Format<CR>", { silent = true } })
