local M = {
  buffer_name_fmt = "[Splitrun #%s]",
  buffer_counter = 1,
}

BUFFER_OPTIONS = {
  swapfile = false,
  modifiable = false,
  bufhidden = "wipe",
  buflisted = false,
}

local function delete_alt(buf)
  local alt = vim.api.nvim_buf_call(buf, function()
    ---@diagnostic disable-next-line: redundant-return-value, param-type-mismatch
    return vim.fn.bufnr("#")
  end)
  if alt ~= buf and alt ~= -1 then
    pcall(vim.api.nvim_buf_delete, alt, { force = true })
  end
end

function M.setup(_)
  M.define_commands()
end

function M.define_commands()
  vim.api.nvim_create_user_command("Splitrun", function(command)
    M.splitrun(command.args)
  end, {
    nargs = "+",
  })

  vim.api.nvim_create_user_command("SplitrunNew", function(command)
    M.splitrun(command.args, { new_split = true })
  end, {
    nargs = "+",
  })
end

function M.splitrun(command, opts)
  opts = opts or {}
  opts.new_split = opts.new_split or false

  local win = M.prev_win

  if
    win == nil
    or not vim.api.nvim_win_is_valid(win)
    or opts.new_split == true
  then
    local w = vim.api.nvim_win_get_width(0)
    local h = vim.api.nvim_win_get_height(0)
    local split_command

    if (w / 2) > h then -- Assumes the height of a cell is approx 2x the width
      split_command = "vsplit"
    else
      split_command = "split"
    end

    vim.cmd(split_command)

    win = vim.api.nvim_get_current_win()
    M.prev_win = win
  end

  vim.api.nvim_win_call(win, function()
    vim.cmd("terminal " .. command)
  end)

  local buf = vim.api.nvim_win_get_buf(win)

  vim.api.nvim_buf_set_name(
    buf,
    string.format(M.buffer_name_fmt, M.buffer_counter)
  )

  -- nvim_buf_set_name creates a new buffer with the old name
  delete_alt(buf)

  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_buf_delete(buf, { force = true })
  end, { buffer = buf })

  for option, value in pairs(BUFFER_OPTIONS) do
    vim.api.nvim_buf_set_option(buf, option, value)
  end

  M.buffer_counter = M.buffer_counter + 1
end

return M
