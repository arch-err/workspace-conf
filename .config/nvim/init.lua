vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.opt.clipboard = "unnamedplus"

-- A remote workspace reaches the client clipboard through the terminal.
if vim.fn.executable("wl-copy") == 0 or not vim.env.WAYLAND_DISPLAY then
  local osc52 = require("vim.ui.clipboard.osc52")
  local clipboard = { name = "OSC 52", copy = {}, paste = {} }
  for _, register in ipairs({ "+", "*" }) do
    local cached = { {}, "v" }
    local copy = osc52.copy(register)
    clipboard.copy[register] = function(lines, regtype)
      cached = { vim.deepcopy(lines), regtype }
      copy(lines)
    end
    -- Remote terminals may support clipboard writes but refuse read queries.
    -- Keep normal Neovim puts local; use terminal paste for external text.
    clipboard.paste[register] = function()
      return cached
    end
  end
  vim.g.clipboard = clipboard
end
