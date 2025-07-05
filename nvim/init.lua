require("plugins")
require("config")
vim.keymap.set("n", "<leader>dd", ":Alpha<CR>", { desc = "Tela inicial (Dashboard)" })
vim.opt.tabstop = 4       -- Número de espaços que um tab aparenta ter
vim.opt.shiftwidth = 4    -- Número de espaços usados para (auto)indentação
vim.opt.expandtab = true  -- Usa espaços em vez de tab real

