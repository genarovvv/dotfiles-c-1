local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

return {
    s("main", {
        t({ "def main():", "    " }), i(1, "pass"),
        t({ "", "", "", 'if __name__ == "__main__":', "    main()" }),
    }),
    s("def", {
        t("def "), i(1, "func"), t("("), i(2, ""), t({ "):", "    " }), i(3, "pass"),
    }),
    s("class", {
        t("class "), i(1, "Name"), t("("), i(2, ""), t({ "):", "    def __init__(self" }),
        i(3, ""), t({ "):", "        " }), i(4, "pass"),
    }),
    s("for", {
        t("for "), i(1, "x"), t(" in "), i(2, "iterable"), t({ ":", "    " }), i(3, "pass"),
    }),
    s("lc", {
        t("["), i(1, "x"), t(" for "), i(2, "x"), t(" in "), i(3, "iterable"), t("]"),
    }),
    s("try", {
        t({ "try:", "    " }), i(1, "pass"),
        t({ "", "except " }), i(2, "Exception"), t({ " as e:", "    " }), i(3, "raise"),
    }),
}
