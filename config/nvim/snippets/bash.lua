local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
    s("shebang", { t({ "#!/usr/bin/env bash", "set -euo pipefail", "" }) }),
    s("for", {
        t("for "), i(1, "item"), t(" in "), i(2, '"$@"'), t({ "; do", "    " }),
        i(3, ""), t({ "", "done" }),
    }),
    s("if", {
        t("if "), i(1, '[[ cond ]]'), t({ "; then", "    " }),
        i(2, ""), t({ "", "fi" }),
    }),
    s("fn", {
        i(1, "function_name"), t({ "() {", "    " }), i(2, ""), t({ "", "}" }),
    }),
}
