-- Check for the current date
local get_current_date = function()
  local current_date_table = os.date("*t", os.time())
  local current_date = string.format("%d-%02d-%02d", current_date_table.year,
    current_date_table.month, current_date_table.day)
  return current_date
end

local allowed_ft = { netrw = true, TelescopePrompt = true }

-- Create the file inside the folder where Explorer is
function CreateJournalEntry()
  if not allowed_ft[vim.bo.filetype] then
    return
  end

  local current_date = get_current_date()
  vim.cmd(":Explore")
  local file_name = vim.fn.expand("%:p") .. current_date
  local journal_entry = string.format("%s.md", file_name)

  local file = io.open(journal_entry, "w+")
  if file == nil then
    error(string.format("Couldn't create file %s.\n",
      journal_entry), 2)
    return
  end
  file:write("# " .. current_date)
  file:close()
  vim.cmd(string.format(":e %s", journal_entry))
end

-- Key to create new entry for journal
vim.keymap.set("n", "<C-c>j", CreateJournalEntry, { silent = true })
