local M = {}

M.plugin = {
  "kyazdani42/nvim-tree.lua",
  cmd = "NvimTreeToggle",
  config = function()
    require("plugins.nvim-tree").config()
  end
}

M.config = function()
  -- Set some variables
  vim.g.vim_tree_special_files = {
    "README.md",
    "LICENSE",
    "Makefile",
    "package.json",
    "package-lock.json",
  }
  vim.g.nvim_tree_ignore = {
    ".git",
    "node_modules",
    "__sapper__",
    ".routify",
    "dist",
    ".cache",
  }
  vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
  }
  vim.g.nvim_tree_add_trailing = 1
  vim.g.nvim_tree_auto_close = 0
  vim.g.nvim_tree_auto_open = 0
  vim.g.nvim_tree_follow = 0
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_gitignore = 1
  vim.g.nvim_tree_group_empty = 0
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_highlight_opened_files = 0
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_root_folder_modifier = ":~"
  vim.g.nvim_tree_side = "left"
  vim.g.nvim_tree_tab_open = 0
  vim.g.nvim_tree_width = 30

  local get_lua_cb = function(cb_name)
    return string.format(
      ":lua require'nvim-tree'.on_keypress('%s')<CR>",
      cb_name
    )
  end

  -- Mappings for nvimtree
  vim.g.nvim_tree_bindings = {
    ["<CR>"] = get_lua_cb "edit",
    ["o"] = get_lua_cb "edit",
    ["<2-LeftMouse>"] = get_lua_cb "edit",
    ["<2-RightMouse>"] = get_lua_cb "cd",
    ["<C-]>"] = get_lua_cb "cd",
    ["<C-[>"] = get_lua_cb "dir_up",
    ["<C-v>"] = get_lua_cb "vsplit",
    ["<C-x>"] = get_lua_cb "split",
    ["<C-t>"] = get_lua_cb "tabnew",
    ["<BS>"] = get_lua_cb "close_node",
    ["<S-CR>"] = get_lua_cb "close_node",
    ["<Tab>"] = get_lua_cb "preview",
    ["I"] = get_lua_cb "toggle_ignored",
    ["H"] = get_lua_cb "toggle_dotfiles",
    ["R"] = get_lua_cb "refresh",
    ["a"] = get_lua_cb "create",
    ["d"] = get_lua_cb "remove",
    ["r"] = get_lua_cb "rename",
    ["<C-r>"] = get_lua_cb "full_rename",
    ["x"] = get_lua_cb "cut",
    ["c"] = get_lua_cb "copy",
    ["p"] = get_lua_cb "paste",
    ["[c"] = get_lua_cb "prev_git_item",
    ["]c"] = get_lua_cb "next_git_item",
    ["q"] = get_lua_cb "close",
  }

  -- default will show icon by default if no icon is provided
  -- default shows no icon by default
  vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",

    git = {
      unstaged = "",
      staged = "",
      unmerged = "",
      renamed = "",
      untracked = "",
      deleted = "",
      ignored = "",
    },

    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
      symlink_open = "",
    },
  }
end

return M
