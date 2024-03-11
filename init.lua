-- bootstrap lazy.nvim, LazyVim and your plugins

-- faster checkhealth
vim.api.nvim_set_var("python3_host_prog", "/ucrt64/bin/python3")
vim.api.nvim_set_var("loaded_python3_provider", 0)
vim.api.nvim_set_var("loaded_perl_provider", 0)
vim.api.nvim_set_var("loaded_node_provider", 0)

require("config.lazy")
