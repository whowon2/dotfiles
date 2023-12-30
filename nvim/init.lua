local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local set = vim.opt

set.shiftwidth = 2
set.relativenumber = true
set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
vim.api.nvim_set_option("clipboard", "unnamed")

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
{
  "olimorris/onedarkpro.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    vim.cmd([[colorscheme onedark]])
  end,
},
{

}
)
