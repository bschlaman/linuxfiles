local M = {}

-- =========================
-- LaTeX formatting
-- =========================

local latex_substitutions = {
  -- ===== whitespace cleanup =====
  { "[ \t]+\n", "\n" },
  { "[ \t]+$", "" },

  -- ===== math delimiters =====
  -- \( → $  and  \) → $
  { "\\%(", "$" },
  { "\\%)", "$" },
  -- inline \[...\] → multiline block
  { "\\%[[ \t]+(.-)[ \t]+\\%]", "\\[\n    %1\n\\]" },

  -- ===== simplify latex constructs =====
  -- {\text{xyz}} → \text{xyz}
  { "{\\text{(%w+)}}", "\\text{%1}" },
  -- {\mathrm{xyz}} → \mathrm{xyz}
  { "{\\mathrm{(%w+)}}", "\\mathrm{%1}" },
  -- _{a} → _a  and  ^{a} → ^a
  { "([_^]){([%a%d])}", "%1%2" },

  -- ===== fix missing braces =====
  -- \mathcal X → \mathcal{X}
  { "\\mathcal ([A-Z])", "\\mathcal{%1}" },
  -- \mathbb X → \mathbb{X}
  { "\\mathbb ([A-Z])", "\\mathbb{%1}" },

  -- ===== macro expansion (must come after brace-fixing) =====
  -- \mathcal{X} → \X
  { "\\mathcal{([A-Z])}", "\\%1" },
  -- \mathbb{X} → \XX
  { "\\mathbb{([A-Z])}", "\\%1%1" },
  -- \text{data} → \data
  { "\\text{data}", "\\data" },
  -- \arg \min → \argmin
  { "\\arg%s*\\min", "\\argmin" },
  -- \arg \max → \argmax
  { "\\arg%s*\\max", "\\argmax" },

  -- ===== spacing (function-based substitution example) =====
  -- ensure space around \, when surrounded by non-space
  { "(%S)\\,(%S)", function(before, after)
    return before .. " \\, " .. after
  end },
  -- ensure space around , ; = when surrounded by non-space
  { "(%S)([,;=])(%S)", function(before, op, after)
    -- skip := and &=
    if op == "=" and (before == ":" or before == "&") then return nil end
    return before .. " " .. op .. " " .. after
  end },
}

function M.format_latex()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local text = table.concat(lines, "\n")

  for _, sub in ipairs(latex_substitutions) do
    text = text:gsub(sub[1], sub[2])
  end

  local new_lines = vim.split(text, "\n")
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
end

return M
