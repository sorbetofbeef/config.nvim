-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

local api, fn = vim.api, vim.fn

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd.normal({ "gg", bang = true })
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if fn.line(".") > 1 then
    return
  end

  local last_line = fn.line([['"]])
  local buff_last_line = fn.line("$")

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = fn.line("w$")
    local win_first_line = fn.line("w0")
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd.normal({ [[g`"]], bang = true })
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd.normal({ [[g`"zz]], bang = true })
    else
      vim.cmd.normal({ [[G'"<c-e>]], bang = true })
    end
  end
end

api.nvim_create_augroup("nvim-lastplace", {})
api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  group = "nvim-lastplace",
  callback = run,
})
