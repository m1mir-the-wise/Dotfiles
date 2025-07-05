require("telescope").setup({
  defaults = {
    file_ignore_patterns = {},
    hidden = true,
    no_ignore = true,
  },
})


-- Aparência
vim.o.termguicolors = true
vim.cmd("colorscheme tokyonight")
vim.opt.number = true

-- Mapas úteis
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = true,
  })
end, { desc = "Find Files (all)" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

-- LSP
local lsp = require("lspconfig")
local cmp = require("cmp")

lsp.lua_ls.setup {}
lsp.ts_ls.setup {}
lsp.pyright.setup {}

-- Autocomplete
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})

-- Treesitter
require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  ensure_installed = { "lua", "python", "javascript", "bash", "html", "css" }
}
