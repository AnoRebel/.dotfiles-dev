local eslint = require("eslint")

eslint.setup({
  bin = 'eslint_d', -- or `eslint`
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "problem" }, -- "directive", "problem", "suggestion", "layout"
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})
