return {
  "ionide/ionide-vim",
  event = "VeryLazy",
  init = function()
    require("lazyvim.util").lsp.on_attach(function(_, buffer)
      local id = vim.api.nvim_create_augroup("Ionide", { clear = false })
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = id,
        buffer = buffer,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end)
  end,
  opts = function(_, opts)
    vim.g["fsharp#lsp_codelens"] = nil -- see init Ionide autocmd group
    -- taken from https://medium.com/@no1.melman10/f-ionide-and-neovim-update-1-d6e316ec087e
    vim.g["fsharp#show_signature_on_cursor_move"] = nil
    vim.g["fsharp#lsp_auto_setup"] = nil
    vim.g["fsharp#workspace_mode_peek_deep_level"] = 4
    vim.api.nvim_create_user_command("FSharpRefreshCodeLens", function()
      vim.lsp.codelens.refresh()
      print("[FSAC] Refreshing CodeLens")
    end, { bang = true })
  end,
}
