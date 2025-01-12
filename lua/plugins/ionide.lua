-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- If you have a parser that is not on the list of supported languages
--      parser_config.fsharp = {
--        install_info = {
--          url = "https://github.com/ionide/tree-sitter-fsharp.git",
--          branch = "main",
--          files = { "src/scanner.c", "src/parser.c" },
--        },
--        filetype = "fsharp",
--      }

M = {}

M.ionide_fsi_cd = function(buffer, cd)
  if not cd[1] then
    vim.fn.feedkeys("cd " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":p:h") .. "\r")
    cd[1] = 1
  end
end

-- Example: `dotnet fsi 01.fsx < ./inputs/01.txt` using stdin as input
M.ionide_fsi_cmd = function(buffer)
  local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":t")
  local file_ext = vim.fn.fnamemodify(file_name, ":e")
  if file_ext == "fsx" then
    local name = vim.fn.fnamemodify(file_name, ":t:r")
    local cmd = "dotnet fsi " .. file_name .. " < ./inputs/" .. name .. ".txt"
    vim.fn.feedkeys(cmd .. "\r")
  end
end

M.ionide_run_script_floating_terminal = function(buffer)
  local cd = {}
  vim.keymap.set("n", "<leader>r", function()
    vim.cmd("write")
    -- Opens a floating terminal (interactive by default)
    require("lazyvim.util").terminal(nil, { cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":p:h") })
    M.ionide_fsi_cd(buffer, cd)
    M.ionide_fsi_cmd(buffer)
    -- normal mode with `<esc><esc>`, control characters  added with `visual mode`
    vim.fn.feedkeys("")
    -- close_with_q
  end, { desc = "Run F# Script", buffer = true, nowait = true })
end

M.ionide_run_script_bellow = function(buffer)
  local cd = {}
  local belowright_split = { "belowright split" }
  -- Run F# Script
  vim.keymap.set("n", "<leader>r", function()
    -- save current script file
    vim.cmd("write")
    if belowright_split[2] then
      -- use previous terminal
      vim.cmd(belowright_split[2])
    else
      -- new terminal
      vim.cmd(belowright_split[1])
      vim.cmd("terminal")
      belowright_split[2] = belowright_split[1] .. " " .. vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    end
    -- insert mode
    vim.fn.feedkeys("a")
    M.ionide_fsi_cd(buffer, cd)
    M.ionide_fsi_cmd(buffer)
    -- normal mode with `<esc><esc>`, control characters  added with `visual mode`
    vim.fn.feedkeys("")
    -- close_with_q
    vim.keymap.set("n", "q", "<C-W>c", { buffer = 0, nowait = true })
  end, { desc = "Run F# Script", buffer = true, nowait = true })
end

M.ionide_on_attach = function(buffer)
  -- M.ionide_run_script_bellow(buffer)
  M.ionide_run_script_floating_terminal(buffer)
end

return {
  "ionide/ionide-vim",

  dependencies = {
    "neovim/nvim-lspconfig", -- exists
    "hrsh7th/cmp-nvim-lsp", -- exists
    "hrsh7th/cmp-buffer", -- exists
    "hrsh7th/cmp-path", -- exists
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp", -- exists
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        -- add fsharp and treesitter
        vim.list_extend(opts.ensure_installed, {
          "fsharp",
        })
      end,
    },
  },

  event = "VeryLazy",
  init = function()
    require("lazyvim.util").lsp.on_attach(function(_, buffer)
      M.ionide_on_attach(buffer)

      vim.api.nvim_buf_create_user_command(buffer, "FSharpRefreshCodeLens", function()
        vim.lsp.codelens.refresh()
        print("[FSAC] Refreshing CodeLens")
      end, { bang = true })

      local group = vim.api.nvim_create_augroup("ionide", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = group,
        buffer = buffer,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })

      vim.api.nvim_create_autocmd("CursorHold", {
        group = group,
        buffer = buffer,
        desc = "TODO - Change the commentstring on cursor hold using Treesitter",
        callback = function()
          -- vim.api.nvim_buf_set_option(0, "commentstring", "(* %s *)")
          vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
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
  end,
}
