local M = {}
local fn = vim.fn
local api = vim.api

M.GetPotionFold = function(lnum)
  if string.match(fn.getline(lnum), '^%s*$') then -- =~? '\v'
    return '-1'
  end
  local this_indent = M.IndentLevel(lnum)
  local next_indent = M.IndentLevel(M.NextNonBlankLine(lnum))
  if next_indent == this_indent then
      return this_indent
    elseif next_indent < this_indent then
      return this_indent
    elseif next_indent > this_indent then
      return '>' .. next_indent
    end
end

M.IndentLevel = function(lnum)
  return fn.indent(lnum) / api.nvim_eval("&shiftwidth")
end

M.NextNonBlankLine = function(lnum)
  local numlines = fn.line('$')
  local current = lnum + 1
  while current <= numlines do
      if fn.getline(current):match '%S' then -- =~? '\v'
        return current
      end
      current = current + 1
  end
  return -2
end

M.CustomFoldText = function()
  -- get first non-blank line
  local fs, line = api.nvim_eval("v:foldstart") -- api.nvim_get_vvar("foldstart") -- vim.v.foldstart
  while fn.getline(fs):match '^%s*$' do -- =~?
    fs = fn.nextnonblank(fs + 1)
  end
  if fs > api.nvim_eval("v:foldend") then
    line = fn.getline(api.nvim_eval("v:foldstart"))
  else
    line = fn.substitute(fn.getline(fs), "\t", fn.repeat(" ", api.nvim_eval("&tabstop")), "g")
  end
  local w = fn.winwidth(0) - api.nvim_eval("&foldcolumn") - (api.nvim_eval("&number") ~= 0 and 8 or 0) -- api.nvim_get_option("number")
  local foldSize = 1 + api.nvim_eval("v:foldend") - api.nvim_eval("v:foldstart")
  local foldSizeStr = " " .. foldSize .. " lines "
  local foldLevelStr = fn.repeat("+--", api.nvim_eval("v:foldlevel"))
  local expansionString = fn.repeat(" ", w - fn.strwidth(foldSizeStr.line.foldLevelStr))
  return line .. expansionString .. foldSizeStr .. foldLevelStr
end

return M
