local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- LSP
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  
  -- Vim Be Good
  {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"},

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Theme
  "folke/tokyonight.nvim",

  -- Alpha (tela inicial)
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local ok_alpha, alpha = pcall(require, "alpha")
      local ok_dashboard, dashboard = pcall(require, "alpha.themes.dashboard")
      if not (ok_alpha and ok_dashboard) then
        return
      end

      dashboard.section.header.val = {
        "",
        "",
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "",
        "       Bem-vindo ao Neovim com Lazy.nvim",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "Novo arquivo", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "Procurar arquivos", ":lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>"),
        dashboard.button("r", "Arquivos recentes", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "Sair", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
    end
  },
})


