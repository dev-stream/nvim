local wk = require("which-key")
wk.add({
  { "<leader>o", icon = " ", group = "obsidian" },
})

return {
  {
    "epwalsh/obsidian.nvim",
    event = { "BufReadPre /docs/Documentos/Obsidian/**.md" },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open on App" },
      { "<leader>og", "<cmd>ObsidianSearch<CR>", desc = "Grep" },
      { "<leader>sO", "<cmd>ObsidianSearch<CR>", desc = "Obsidian Grep" },
      { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
      { "<leader>o<space>", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Files" },
      { "<leader>fo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Obsidian Files" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
      { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Tags" },
      { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
      { "<leader>ol", "<cmd>ObsidianLink<CR>", desc = "Link" },
      { "<leader>oL", "<cmd>ObsidianLinks<CR>", desc = "Links" },
      { "<leader>oN", "<cmd>ObsidianLinkNew<CR>", desc = "New Link" },
      { "<leader>oe", "<cmd>ObsidianExtractNote<CR>", desc = "Extract Note" },
      { "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "Workspace" },
      { "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename" },
      { "<leader>oi", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Image" },
      { "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Daily Notes" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "$USERPROFILE/vaults/work",
        },
      },

      notes_subdir = "Notes",

      daily_notes = {
        folder = "Journal/Entries/Daily",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = "$USERPROFILE/vaults/work/_data_/templates/journal/daily_entry.md",
      },

      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<C-c>"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },

      templates = {
        subdir = "_data_/templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },

      follow_url_func = function(url)
        if vim.env.MSYSTEM == "UCRT64" then
          vim.fn.jobstart({ "start", url })
        else
          vim.fn.jobstart({ "xdg-open", url })
        end
      end,

      attachments = {
        img_folder = "_data_/media",
      },
    },
  },
}
