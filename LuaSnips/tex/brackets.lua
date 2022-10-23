local snips, autosnips = {}, {}

local context = require('snips.context')

-- local texpairs = {
-- 	{ '(', ')' },
-- 	{ '\\left(', '\\right)' },
-- 	{ '\\big(', '\\big)' },
-- 	{ '\\Big(', '\\Big)' },
-- 	{ '\\bigg(', '\\bigg)' },
-- 	{ '\\Bigg(', '\\Bigg)' },
-- }

-- local function choices_from_pairlist(ji, list)
-- 	local choices = {}
-- 	for _, pair in ipairs(list) do
-- 		table.insert(choices, {
-- 			t(pair[1]), r(1, 'inside_pairs', dl(1, l.LS_SELECT_DEDENT)), t(pair[2])
-- 		})
-- 	end
-- 	return c(ji, choices)
-- end

snips = {
	-- s(
	-- 	{ trig = '(', name = 'parenthesis', dscr = 'Different kinds of parenthesis' },
	-- 	{ choices_from_pairlist(1, texpairs) },
	-- 	{ condition = context.in_text }
	-- ),

	s(
		{ trig = 'lr(', name = 'left( right)' },
		{ t { '\\left( ' }, i(1), t { '\\right)' } },
		{ condition = context.in_mathzone, show_condition = context.in_mathzone }
	),
	s(
		{ trig = 'lr|', name = 'leftvert rightvert' },
		{ t { '\\left\\lvert ' }, i(1), t { '\\right\\lvert' } },
		{ condition = context.in_mathzone, show_condition = context.in_mathzone }
	),
	s(
		{ trig = 'lr{', name = 'left\\{ right\\}' },
		{ t { '\\left\\{ ' }, i(1), t { '\\right\\}' } },
		{ condition = context.in_mathzone, show_condition = context.in_mathzone }
	),
	s(
		{ trig = 'lrb', name = 'left\\{ right\\}' },
		{ t { '\\left\\{ ' }, i(1), t { '\\right\\}' } },
		{ condition = context.in_mathzone, show_condition = context.in_mathzone }
	),
	s(
		{ trig = 'lr[', name = 'left[ right]' },
		{ t { '\\left[ ' }, i(1), t { '\\right]' } },
		{ condition = context.in_mathzone, show_condition = context.in_mathzone }
	),
}

autosnips = {
	s(
		{ trig = 'bpm', name = 'pmatrix Environment' },
		{ t { '\\begin{pmatrix}', '\t' }, i(1), t { '', '\\end{pmatrix}' } },
		{ condition = context.in_mathzone }
	),
	s(
		{ trig = 'bbm', name = 'bmatrix Environment' },
		{ t { '\\begin{bmatrix}', '\t' }, i(1), t { '', '\\end{bmatrix}' } },
		{ condition = context.in_mathzone }
	),
	s(
		{ trig = 'cvec', name = 'column vector' }, {
			t { '\\begin{pmatrix}', '\t' },
			i(1, 'x'),
			t '}_',
			i(2, '1'),
			t { '\\\\', '\\vdots \\\\', '' },
			rep(1),
			t '_',
			i(3, 'n'),
			t { '', '\\end{pmatrix}' },
		}, { condition = context.in_mathzone }
	),
	s(
		{ trig = 'lra', name = 'leftangle rightangle' },
		{ t { '\\langle ' }, i(1), t { '\\rangle' } },
		{ condition = context.in_mathzone }
	),
}

return snips, autosnips
