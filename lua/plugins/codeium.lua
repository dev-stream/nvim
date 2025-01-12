local logpath = vim.fs.normalize(vim.fn.stdpath("cache") .. "/codeium/codeium.log")

local codeium_source -- cache the source when disabled
vim.api.nvim_create_user_command("CodeiumToggle", function()
  local sources = require("cmp").core.sources
  local s = vim.tbl_filter(function(t) return t.name == "codeium" and t.source.server.is_healthy() end, sources)[1]
  if s ~= nil then
    codeium_source = s
    require("cmp").unregister_source(s.id)
    vim.notify("CodeiumToggle disabled")
  else
    if codeium_source ~= nil then
      sources[codeium_source.id] = codeium_source
      vim.notify("CodeiumToggle enabled")
    end
  end
end, { desc = "CodeiumToggle" })

vim.api.nvim_create_user_command("CodeiumLogClear", function() vim.fn.writefile({}, logpath) end, { desc = "View CodeiumLog" })

vim.api.nvim_create_user_command("CodeiumLog", function() vim.cmd.e(logpath) end, { desc = "View CodeiumLog" })

vim.api.nvim_create_user_command("CodeiumCmpSourceHealthy", function()
  local s = vim.tbl_filter(function(t) return t.name == "codeium" end, require("cmp").core.sources)[1]
  if s ~= nil then
    if s.source.server.is_healthy() then
      vim.notify("Codeium cmp source server is healthy")
    else
      vim.notify("Codeium cmp source server is not healthy")
    end
  else
    vim.notify("Codeium cmp source server is not healthy")
  end
end, { desc = "check for current Codeium cmp source server health" })

return {}
