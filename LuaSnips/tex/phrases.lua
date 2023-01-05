local snips, autosnips = {}, {}

local conds_expand = require("luasnip.extras.conditions.expand")
local tex = require("util.latex")
local position = require("util.position")

snips = {
  s({ trig = "cite", name = "cross refrence" }, {
    t("\\cite["),
    i(1),
    t("]{"),
    i(2),
    t("}"),
  }, {
    condition = tex.in_text,
    show_condition = tex.in_text,
    callbacks = {
      [2] = {
        [events.enter] = function()
          require("telescope").extensions.bibtex.bibtex(require("telescope.themes").get_dropdown({ previewer = false }))
        end,
      },
    },
  }),

  s(
    { trig = "cf", name = "confer/conferatur" },
    { t("cf.~") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "ses", name = "short exact sequence", dscr = "text: short exact sequence." },
    { t("short exact sequence") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s(
    { trig = "klt", name = "Kawamata log terminal", dscr = "text: Kawamata log terminal." },
    { t("Kawamata log terminal") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
}

autosnips = {
  s({ trig = "iee", name = "id est" }, { t("i.e., ") }, { condition = tex.in_text, show_condition = tex.in_text }),
  s(
    { trig = "egg", name = "exempli gratia" },
    { t("e.g., ") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "stt", name = "such that" },
    { t("such that") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "resp", name = "`respectively" },
    { t("resp.\\ ") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "qf", name = "Q-factorial" },
    { t("\\(\\mathbb{Q}\\)-factorial") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s({ trig = "([qr])c", name = "Cartier", regTrig = true }, {
    f(function(_, snip)
      return "\\(\\mathbb{" .. string.upper(snip.captures[1]) .. "}\\)-Cartier"
    end, {}),
  }, { condition = tex.in_text, show_condition = tex.in_text }),

  s({ trig = "([qr])d", name = "divisor", regTrig = true }, {
    f(function(_, snip)
      return "\\(\\mathbb{" .. string.upper(snip.captures[1]) .. "}\\)-divisor"
    end, {}),
  }, { condition = tex.in_text, show_condition = tex.in_text }),

  s(
    { trig = "cd", name = "Cartier divisor" },
    { t("Cartier divisor") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "wd", name = "Weil divisor" },
    { t("Weil divisor") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "nc", name = "-1-curve" },
    { t("\\((-1)\\)-curve") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "iff", name = "if and only if" },
    { t("if and only if ") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "wrt", name = "with respect to" },
    { t("with respect to ") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "nbhd", name = "neighbourhood" },
    { t("neighbourhood") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "pef", name = "pseudo-effective" },
    { t("pseudo-effective") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "gbgs", name = "generated by global sections" },
    { t("generated by global sections") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "fgd", name = "finitely generated" },
    { t("finitely generated") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "mfs", name = "Mori fibre space" },
    { t("Mori fibre space") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "bpf", name = "base point free" },
    { t("base point free") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "snc", name = "simple normal crossing" },
    { t("simple normal crossing") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "lmm", name = "log minimal model" },
    { t("log minimal model") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "tfae", name = "the following are equivalent" },
    { t("the following are equivalent") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    { trig = "Tfae", name = "The following are equivalent" },
    { t("The following are equivalent") },
    { condition = conds_expand.line_begin * tex.in_text, show_condition = position.line_begin * tex.in_text }
  ),

  s({ trig = "([wW])log", name = "without loss of generality", regTrig = true }, {
    f(function(_, snip)
      return snip.captures[1] .. "ithout loss of generality"
    end, {}),
  }, { condition = conds_expand.line_begin * tex.in_text, show_condition = position.line_begin * tex.in_text }),

  s(
    { trig = "cref", name = "\\cref{}" },
    { t("\\cref{"), i(1), t("}") },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
}

return snips, autosnips
