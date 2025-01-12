-- LSP keymaps
return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- Disabled keymap (use "gK" as alternative to "Signature Help")
    keys[#keys + 1] = { "<c-k>", false, mode = "i", desc = "Signature Help", has = "signatureHelp" }
  end,
}
