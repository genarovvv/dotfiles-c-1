local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local f  = ls.function_node

return {
    s("main", {
        t({ "#include <iostream>", "", "int main(int argc, char **argv) {", "    " }),
        i(1, ""), t({ "", "    return 0;", "}" }),
    }),
    s("for", {
        t("for (int "), i(1, "i"), t(" = 0; "),
        f(function(args) return args[1][1] end, { 1 }),
        t(" < "), i(2, "n"), t("; "),
        f(function(args) return args[1][1] end, { 1 }),
        t({ "++) {", "    " }), i(3, ""), t({ "", "}" }),
    }),
    s("class", {
        t("class "), i(1, "Name"), t({ " {", "public:", "    " }),
        i(2, ""), t({ "", "private:", "    " }), i(3, ""), t({ "", "};" }),
    }),
    s("cout", { t('std::cout << '), i(1, '""'), t(' << std::endl;') }),
    s("vec",  { t("std::vector<"), i(1, "int"), t("> "), i(2, "v"), t(";") }),
    s("lambda", {
        t("auto "), i(1, "fn"), t(" = ["), i(2, ""), t("]("),
        i(3, ""), t(") { return "), i(4, ""), t("; };"),
    }),
}
