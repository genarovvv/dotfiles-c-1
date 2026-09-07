local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
    s("main", { t({ "fn main() {", "    " }), i(1, ""), t({ "", "}" }) }),
    s("fn", {
        t("fn "), i(1, "nombre"), t("("), i(2, ""), t(") -> "), i(3, "()"),
        t({ " {", "    " }), i(4, "todo!()"), t({ "", "}" }),
    }),
    s("for", {
        t("for "), i(1, "x"), t(" in "), i(2, "0..n"), t({ " {", "    " }),
        i(3, ""), t({ "", "}" }),
    }),
    s("struct", {
        t("#[derive(Debug)]"), t({ "", "struct " }), i(1, "Nombre"),
        t({ " {", "    " }), i(2, ""), t({ "", "}" }),
    }),
    s("pln", { t('println!("'), i(1, "{}"), t('", '), i(2, ""), t(");") }),
}
