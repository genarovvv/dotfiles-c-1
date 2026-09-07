local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local f  = ls.function_node

return {
    s("main", {
        t({ "int main(int argc, char **argv) {", "    " }),
        i(1, ""),
        t({ "", "    return 0;", "}" }),
    }),
    s("for", {
        t("for (int "), i(1, "i"), t(" = 0; "),
        f(function(args) return args[1][1] end, { 1 }),
        t(" < "), i(2, "n"), t("; "),
        f(function(args) return args[1][1] end, { 1 }),
        t({ "++) {", "    " }), i(3, ""), t({ "", "}" }),
    }),
    s("while", {
        t("while ("), i(1, "cond"), t({ ") {", "    " }), i(2, ""), t({ "", "}" }),
    }),
    s("if", {
        t("if ("), i(1, "cond"), t({ ") {", "    " }), i(2, ""), t({ "", "}" }),
    }),
    s("struct", {
        t("typedef struct {"), t({ "", "    " }), i(1, ""),
        t({ "", "} " }), i(2, "Name"), t(";"),
    }),
    s("pf", {
        t('printf("'), i(1, "%s"), t('"'), i(2, ""), t(");"),
    }),
    s("guard", {
        t("#ifndef "), i(1, "HEADER_H"), t({ "", "#define " }),
        f(function(args) return args[1][1] end, { 1 }),
        t({ "", "", "" }), i(2, ""), t({ "", "", "#endif" }),
    }),
}
