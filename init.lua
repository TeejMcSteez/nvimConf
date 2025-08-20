-- Config Docs
-- https://www.lazyvim.org/

-- Base config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = " "

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
})

-- Treesitter syntax highlighting
require("nvim-treesitter.configs").setup({
  ensure_installed = { "javascript", "typescript", "html", "css", "json", "svelte", "cpp", "c_sharp" },
  highlight = { enable = true },
})

-- LSP install and setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "html", "cssls", "jsonls", "eslint", "svelte" },
})

-- Hook into lspconfig
local lspconfig = require("lspconfig")
for _, server in ipairs({ "ts_ls", "html", "cssls", "jsonls", "eslint", "svelte" }) do
  lspconfig[server].setup({})
end

