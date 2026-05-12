-- Check for the current date
local get_current_date = function()
  local current_date_table = os.date("*t", os.time())
  local current_date = tostring(current_date_table.year .. "-" ..
    current_date_table.month .. "-" .. current_date_table.day)
  return current_date
end

-- Create the file inside the folder where Explorer is
function CreateJournalEntry()
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
  print(string.format("journal entry %s created successfully!", journal_entry))
  vim.cmd(string.format(":e %s", journal_entry))
end
