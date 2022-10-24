local snips = {}

local conds_expand = require('luasnip.extras.conditions.expand')
local position = require('snips.position')

snips = {
	s(
		{ trig = 'temp', dscr = 'frequently used templates' },
		c(1, {
			sn(nil, {
				t {
					'\\documentclass{article}',
					'\\input{~/Tex/preamble_meta}',
					'',
					'\\usepackage[margin=1in]{geometry}',
					'\\linespread{1.3}',
					'\\pagestyle{headings}',
					'',
					'% \\input{~/Tex/bibtexref}',
					'\\input{~/Tex/preamble_ref}',
					'',
					'\\title{',
				},
				i(1),
				t {
					'}',
					'% \\author{Jia Jia}',
					'',
					'\\begin{document}',
					'',
					'\\maketitle',
					'',
				},
				i(2),
				t {
					'',
					'',
					'\\end{document}',
				},
			}),
			sn(nil, {
				t {
					'\\documentclass[aspectratio=169]{beamer}',
					'\\usetheme[mode=light]{nord}',
					'\\input{~/Tex/preamble_meta_b}',
					'',
					'\\graphicspath{{./assets/}}',
					'',
					'\\title[short title]{LONG TITLE}',
					'\\subtitle{subtitle}',
					'\\date{\\today}',
					'\\author{Jia Jia}',
					'\\institute[short institute]{LONG INSTITUTE}',
					'\\titlegraphic{nus-logo}',
					'',
					'\\hypersetup{',
					'  colorlinks=true,',
					'  linkcolor={nordNine},',
					'  citecolor={nordNine},',
					'  urlcolor={nordNine}',
					'}',
					'',
					'\\begin{document}',
					'\\titlepage',
					'',
					'\\section*{Introduction}',
					'',
					'\\begin{frame}',
					'\t\\frametitle{Introduction}',
					'',
					'',
				},
				i(1),
				t {
					'',
					'',
					'\\end{frame}',
					'',
					'%',
					'',
					'\\section{Main Results}',
					'',
					'%',
					'',
					'\\section{Question?}',
					'',
					'\\end{document}',
				},
			}),
			sn(nil, {
				t {
					'\\documentclass[11pt]{amsart}',
					'',
					'% Standard Packages',
					'\\usepackage{amsmath}',
					'\\usepackage{amssymb}',
					'\\usepackage{amsthm}',
					'\\usepackage{enumitem}',
					'\\usepackage[T1]{fontenc}',
					'\\usepackage{mathtools}',
					'\\usepackage{microtype}',
					'\\usepackage[dvipsnames]{xcolor}',
					'\\usepackage[all,cmtip]{xy}',
					'',
					'% BibTeX and Ref',
					'\\usepackage[pagebackref]{hyperref}',
					'\\usepackage[alphabetic]{amsrefs}',
					'\\usepackage[capitalise]{cleveref}',
					'',
					'\\hypersetup{',
					'\tcolorlinks=true,',
					'\tlinkcolor=MidnightBlue,',
					'\tcitecolor=MidnightBlue,',
					'\tfilecolor=magenta,',
					'\turlcolor=MidnightBlue',
					'}',
					'',
					'% Pagestyle',
					'\\usepackage[margin=1in]{geometry}',
					'\\linespread{1.3}',
					'',
					'% Environments.',
					'\\theoremstyle{plain}',
					'\\newtheorem{theorem}{Theorem}[section]',
					'\\newtheorem{axiom}[theorem]{Axiom}',
					'\\newtheorem{conjecture}[theorem]{Conjecture}',
					'\\newtheorem{corollary}[theorem]{Corollary}',
					'\\newtheorem{hypothesis}[theorem]{Hypothesis}',
					'\\newtheorem{lemma}[theorem]{Lemma}',
					'\\newtheorem{proposition}[theorem]{Proposition}',
					'',
					'\\theoremstyle{definition}',
					'\\newtheorem{definition}[theorem]{Definition}',
					'\\newtheorem{assumption}[theorem]{Assumption}',
					'\\newtheorem{example}[theorem]{Example}',
					'\\newtheorem{question}[theorem]{Question}',
					'\\newtheorem*{ack}{Acknowledgement}',
					'',
					'\\theoremstyle{remark}',
					'\\newtheorem{claim}[theorem]{Claim}',
					'\\newtheorem{notation}[theorem]{Notation}',
					'\\newtheorem{fact}[theorem]{Fact}',
					'\\newtheorem{remark}[theorem]{Remark}',
					'\\newtheorem{setup}[theorem]{}',
					'\\newtheorem*{remark*}{Remark}',
					'\\newtheorem*{notation*}{Notation and Terminology}',
					'',
					'\\numberwithin{equation}{section}',
					'',
					'% Commands',
					'% Algebra',
					'\\DeclareMathOperator{\\Ann}{Ann}',
					'\\DeclareMathOperator{\\Ass}{Ass}',
					'\\DeclareMathOperator{\\Aut}{Aut}',
					'\\DeclareMathOperator{\\Frac}{Frac}',
					'\\DeclareMathOperator{\\HN}{HN}',
					'\\DeclareMathOperator{\\Span}{Span}',
					'\\DeclareMathOperator{\\Sym}{Sym}',
					'\\DeclareMathOperator{\\Tr}{Tr} % trace',
					'\\DeclareMathOperator{\\coeff}{coeff}',
					'\\DeclareMathOperator{\\length}{length}',
					'\\DeclareMathOperator{\\mult}{mult}',
					'\\DeclareMathOperator{\\ord}{ord}',
					'\\DeclareMathOperator{\\rank}{rank}',
					'\\DeclareMathOperator{\\rk}{rk}',
					'\\DeclareMathOperator{\\sign}{sign}',
					'\\DeclareMathOperator{\\trdeg}{tr.deg}',
					'',
					'% Groups',
					'\\DeclareMathOperator{\\GL}{GL}',
					'\\DeclareMathOperator{\\Gal}{Gal}',
					'\\DeclareMathOperator{\\PGL}{PGL}',
					'\\DeclareMathOperator{\\PSL}{PSL}',
					'\\DeclareMathOperator{\\SL}{SL}',
					'',
					'% Homological Algebra',
					'\\DeclareMathOperator{\\coker}{coker}',
					'\\DeclareMathOperator{\\Ext}{Ext}',
					'\\DeclareMathOperator{\\Hm}{H} % homology/cohomology',
					'\\DeclareMathOperator{\\Hom}{Hom}',
					'\\DeclareMathOperator{\\SExt}{\\mathcal{E}\\!\\mathit{xt}}',
					'\\DeclareMathOperator{\\SHom}{\\mathcal{H}\\!\\mathit{om}}',
					'\\DeclareMathOperator{\\Tor}{Tor}',
					'\\DeclareMathOperator{\\id}{id}',
					'\\DeclareMathOperator{\\im}{Im} % image',
					'',
					'% Geometry',
					'\\DeclareMathOperator{\\Alb}{Alb}',
					'\\DeclareMathOperator{\\Amp}{Amp}',
					'\\DeclareMathOperator{\\Bir}{Bir}',
					'\\DeclareMathOperator{\\Bs}{Bs}',
					'\\DeclareMathOperator{\\CH}{CH}',
					'\\DeclareMathOperator{\\Chow}{Chow}',
					'\\DeclareMathOperator{\\Cl}{Cl}',
					'\\DeclareMathOperator{\\Diff}{Diff}',
					'\\DeclareMathOperator{\\Div}{Div}',
					'\\DeclareMathOperator{\\End}{End}',
					'\\DeclareMathOperator{\\Exc}{Exc}',
					'\\DeclareMathOperator{\\Fix}{Fix}',
					'\\DeclareMathOperator{\\Grass}{Grass}',
					'\\DeclareMathOperator{\\Nklt}{Nklt}',
					'\\DeclareMathOperator{\\Pic}{Pic}',
					'\\DeclareMathOperator{\\Proj}{Proj}',
					'\\DeclareMathOperator{\\Res}{Res}',
					'\\DeclareMathOperator{\\SBs}{SBs}',
					'\\DeclareMathOperator{\\SEnd}{SEnd}',
					'\\DeclareMathOperator{\\Sing}{Sing}',
					'\\DeclareMathOperator{\\Spec}{Spec} % Spectrum',
					'\\DeclareMathOperator{\\Supp}{Supp} % Support',
					'\\DeclareMathOperator{\\Val}{Val}',
					'\\DeclareMathOperator{\\Vol}{Vol}',
					'\\DeclareMathOperator{\\ch}{ch}',
					'\\DeclareMathOperator{\\codim}{codim}',
					'\\DeclareMathOperator{\\discrep}{discrep} % discrepancy',
					'\\DeclareMathOperator{\\lct}{lct}',
					'\\DeclareMathOperator{\\td}{td}',
					'\\DeclareMathOperator{\\var}{\\mathcal{Var}}',
					'',
					'% Cones',
					'\\DeclareMathOperator{\\Nef}{Nef}',
					'\\DeclareMathOperator{\\NE}{NE}',
					'\\DeclareMathOperator{\\cNE}{\\overline{NE}} % Mori cone',
					'\\DeclareMathOperator{\\NS}{NS}',
					'\\DeclareMathOperator{\\Mob}{Mob}',
					'\\DeclareMathOperator{\\Mov}{Mov}',
					'\\DeclareMathOperator{\\PE}{PE}',
					'',
					'',
					'% Miscellaneous',
					'\\newcommand{\\Romannum}[1]{\\uppercase\\expandafter{\\romannumeral #1}}',
					'\\newcommand{\\romannum}[1]{\\romannumeral #1\\relax}',
					'',
					'\\DeclarePairedDelimiter{\\rup}{\\lceil}{\\rceil}',
					'\\DeclarePairedDelimiter{\\rdown}{\\lfloor}{\\rfloor}',
					'\\DeclarePairedDelimiter{\\abs}{\\lvert}{\\rvert}',
					'\\DeclarePairedDelimiter{\\norm}{\\lVert}{\\rVert}',
					'\\DeclarePairedDelimiterX{\\pair}[2]{\\langle}{\\rangle}{#1,#2}',
					'',
					'% Author, Title, etc.',
					'\\title[short title]',
					'{long title}',
					'',
					'\\author{Jia Jia}',
					'\\address{National University of Singapore, Singapore 119076, Republic of Singapore}',
					'\\email{jia\\_jia@u.nus.edu}',
					'',
					'\\subjclass[2020]{',
					'% 37P55, % Arithmetic dynamics on general algebraic varieties',
					'% 14G05, % Rational points',
					'% 14E30, % Minimal model program (Mori theory, extremal rays)',
					'% 08A35. % Automorphisms and endomorphisms of algebraic structures',
					'}',
					'\\keywords{keywords}',
					'',
					'\\begin{document}',
					'',
					'\\begin{abstract}',
					'abstract',
					'\\end{abstract}',
					'',
					'\\maketitle',
					'\\tableofcontents',
					'',
					'\\section{Introduction}\\label{sec:introduction}',
					'',
					'',
				},
				i(1),
				t {
					'',
					'',
					'% References',
					'',
					'\\bibliographystyle{ieeetr}',
					'\\bibliography{Jiabibtex.bib}',
					'',
					'\\end{document}',
				},
			}),
			sn(nil, {
				t {
					'% version 27 March 2022',
					'\\documentclass[11pt,a4paper]{amsart}',
					'\\input{~/Tex/preamble_meta}',
					'',
					'\\usepackage[margin=1in]{geometry}',
					'\\linespread{1.3}',
					'\\pagestyle{headings}',
					'',
					'\\input{~/Tex/bibtexref}',
					'',
					'\\title{Answers to queries of the referee}',
					'\\author{}',
					'\\date{}',
					'',
					'\\begin{document}',
					'',
					'\\maketitle',
					'',
					'Many thanks to the referee for very careful reading, critical questions, and the valuable suggestions',
					'to improve the paper.',
					'The following are the main changes based on the suggestions.',
					'',
					'\\par \\vskip 1pc',
					'\\textbf{Changes according to the comments of the referee:}',
					'',
					'{\\color{blue}(1)}.',
					'',
				},
				i(1),
				t {
					'',
					'',
					'\\normalsize',
					'\\textbf{Revision}:',
					'',
					'\\par \\vskip 1pc',
					'\t{\\color{blue}(2)}.',
					'',
					'',
					'% References',
					'',
					'\\bibliographystyle{ieeetr}',
					'\\bibliography{Jiabibtex.bib}',
					'',
					'\\end{document}',
				},
			}),
		}),
		{
			condition = position.on_top * conds_expand.line_begin,
			show_condition = position.on_top
		}
	),
}

return snips
