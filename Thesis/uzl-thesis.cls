%
%
% LaTeX Class file for thesis written
% at the University of Lübeck
%
%
% This class file was originally designed by Till Tantau
%
%
% The copyright of this file lies with the University of Lübeck. It
% can (and should) be used by students for their Bachelor and Master
% theses.
%
%
% Changelog
%
% 2021-01-26, Till Tantau
% - Moved patches to lstlisting to separat style file because
%   of changes in the LaTeX kernel and order of execution of
%   \AtBeginDocument
%
% 2019-11-21, Till Tantau
% - Made \UzLStyle and thus also \uzlemph robust
% - Fixed "Masterarbeit" key, now "Masterarbet" only supported for 2019-07
%   version.
% - Changed basic lineskip to 14.5pt instead of 14pt.
%
% 2019-07-01 Till Tantau
% - First version

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uzl-thesis}[2022/01/26 University of Luebeck Thesis Class]



%%%%%%%%%%%%%%%%%%%%%
%
% Class Options
%
%%%%%%%%%%%%%%%%%%%%%



%%%
%
% Version
%
%%%

\newif\ifuzlversion@set
\newif\ifuzlversion@nineteenseven
\newif\ifuzlversion@nineteeneleven
\newif\ifuzlversion@twentyeleven
\newif\ifuzlversion@twentytwoone

\DeclareOption{version-2019-07}{\uzlversion@nineteenseventrue\uzlversion@settrue}
\DeclareOption{version-2019-11}{\uzlversion@nineteeneleventrue\uzlversion@settrue}
\DeclareOption{version-2020-11}{\uzlversion@twentyeleventrue\uzlversion@settrue}
\DeclareOption{version-2022-01}{\uzlversion@twentytwoonetrue\uzlversion@settrue}


%%%
%
% Languages
%
%%%

% Only two langauges are possible and allowed: German and
% English. This is goverened by the two options german and english. At
% least one of them *must* be used.

\newif\ifuzl@language@set

\DeclareOption{german}{
  \uzl@language@settrue
  \uzl@germantrue
}

\DeclareOption{english}{
  \uzl@language@settrue
  \uzl@englishtrue
}

% The following are true if one of the languages is set

\newif\ifuzl@german
\newif\ifuzl@english



%
% Process them now
%

\ProcessOptions


%%
%
% Make sure that luatex is used
%
%%

\RequirePackage{ifluatex}

\ifluatex
\else
  \ClassError{uzl-thesis}{%
    lualatex not used!
    \MessageBreak 
    You must use lualatex and not pdflatex
  }
  {%
    The thesis class can only be used with
    \MessageBreak
    lualatex and not with the older pdflatex (nor
    \MessageBreak
    with xelatex and other versions). Adjust your
    \MessageBreak
    editor or makefile so that lualatex is used.
    \MessageBreak
  }
\fi




%%
%
% Key management
%
%%

\RequirePackage{pgf}

\DeclareRobustCommand\UzLStyle{\pgfqkeys{/uzlstyle}}
\def\UzLThesisSetup{\pgfqkeys{/uzlthesissetup}}




%%%%%%%%%%%%%%%
%
% Styling
%
% We use a simple pgfkeys-based approach to styling things.
%
%%%%%%%%%%%%%%%

\UzLStyle{
  %
  % Basic handler:
  %
  % new style/.uzl style = inherit from
  %
  % will create a new style that will install
  %
  % "new style font, new style layout, new style color"
  %
  % each of which will be installed as a style calling
  %
  % "inherit from font", "inherit from layout", and "inherit from
  % color", respectively  
  %
  /handlers/.uzl style inherits from/.code={
    \edef\uzl@temp{  
      \pgfkeyscurrentpath/.style={
        \pgfkeyscurrentpath\space font,
        \pgfkeyscurrentpath\space layout,
        \pgfkeyscurrentpath\space color
      },
      \pgfkeyscurrentpath\space font/.style={#1 font},
      \pgfkeyscurrentpath\space layout/.style={#1 layout},
      \pgfkeyscurrentpath\space color/.style={#1 color},
    }
    \expandafter\pgfkeys\expandafter{\uzl@temp}
  },
  %
  % The plain style does nothing.
  %
  plain font/.code={},
  plain layout/.code={},
  plain color/.code={},
  %
  % The structure style is used for titles and headlines
  %
  structure/.uzl style inherits from = plain,
}








%%%%%%%%%%%%%%%%%%%%%
%
% Main Inits
%
%%%%%%%%%%%%%%%%%%%%%







%%%
%
% Setup of sizes (chosen and fixed by Till Tantau)
%
%%%

%
% Font size: In principle, 11pt as base. However, depending on the
% chosen font, the sizes get adjusted to ensure that all fonts produce
% approximately the same number of pages.
%
% For this, the line spacing is fixed. However, the font sizes at
% different size can be adjusted using the following dimensions

\newdimen\uzl@Huge
\newdimen\uzl@huge
\newdimen\uzl@LARGE
\newdimen\uzl@Large
\newdimen\uzl@large
\newdimen\uzl@normalsize
\newdimen\uzl@normalsizeskip
\newdimen\uzl@small
\newdimen\uzl@footnotesize
\newdimen\uzl@scriptsize
\newdimen\uzl@tiny

\uzl@Huge          25pt
\uzl@huge          20pt
\uzl@LARGE         17pt
\uzl@Large         14pt 
\uzl@large         12pt
\uzl@normalsize    11pt
\uzl@small         10pt
\uzl@footnotesize   9pt
\uzl@scriptsize     8pt
\uzl@tiny           6pt

\uzl@normalsizeskip 14.5pt 

\newcommand\Huge{\@setfontsize\Huge\uzl@Huge{30}}
\newcommand\huge{\@setfontsize\huge\uzl@huge{25}}
\newcommand\LARGE{\@setfontsize\LARGE\uzl@LARGE{22}}
\newcommand\Large{\@setfontsize\Large\uzl@Large{18}}
\newcommand\large{\@setfontsize\large\uzl@large{15}}
\renewcommand\normalsize{%
   \@setfontsize\normalsize\uzl@normalsize\uzl@normalsizeskip%
   \abovedisplayskip 12\p@ \@plus3\p@ \@minus6\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\newcommand\small{%
   \@setfontsize\small\uzl@small{13}%
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 7\p@ \@plus2\p@ \@minus2\p@
               \parsep 3\p@ \@plus2\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\footnotesize{%
   \@setfontsize\footnotesize\uzl@footnotesize{12}%
   \abovedisplayskip 9\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 5\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\scriptsize{\@setfontsize\scriptsize\uzl@scriptsize{10.25}}
\newcommand\tiny{\@setfontsize\tiny\uzl@tiny\@viiipt}

\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\headheight{12\p@}
\setlength\headsep   {25\p@}
\setlength\topskip   {11\p@}
\setlength\footskip{30\p@}
\setlength\maxdepth{.5\topskip} 

\setlength\footnotesep{7.7\p@}
\setlength{\skip\footins}{10\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{3\p@ \@plus 1\p@ \@minus 1\p@}

\parindent20pt

%
% Page geometry: Use geometry package with "ample margin" to ensure
% that there are normally 12 to 14 words per line 
%

\RequirePackage[a4paper,left=3cm,right=3cm,top=3cm,bottom=3.75cm,footskip=1.5cm,headsep=1cm]{geometry}

\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\raggedbottom


%
% More sizes
%
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301



%
%
% Setup of headings and footers (chosen and fixed by Till Tantau)
%
%


%
% Footline: Page number
%

\UzLStyle{
  head and foot/.uzl style inherits from = structure
}

\pagenumbering{roman}  % but no page numbers are printed because:
\pagestyle{empty}       % this is actually already in the kernel

\def\ps@plain{\let\@mkboth\@gobbletwo
  \let\@oddhead\@empty
  \def\@oddfoot{\reset@font%
    \UzLStyle{foot}%
    \UzLStyle{page number}%
    \hfil\UzLStyle{page number pre}%
    \thepage%
    \UzLStyle{page number post}\hfil}
  \let\@evenhead\@empty
  \let\@evenfoot\@oddfoot
}

\UzLStyle{
  foot/.uzl style inherits from = head and foot,
  page number/.uzl style inherits from = plain,
  page number pre/.code={},
  page number post/.code={},
}


%
% Headline: 
%

\def\ps@headings{%
  \ps@plain
  \def\@oddhead{\reset@font%
    \minipage{\textwidth}%
    \UzLStyle{head}%
    \UzLStyle{head pre}%
    \rightmark%%
    \UzLStyle{head post}\endminipage}
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \def\chaptermark##1{\markright{\thechapter\kern.75em##1}}
}

\UzLStyle{
  head/.uzl style inherits from = head and foot,
  head pre/.code={},
  head post/.code={},
}



%%%%%%%%%%%%%%%%%%%%
%
% Chapters and sections (partly taken from report.cls)
%
%%%%%%%%%%%%%%%%%%%%

\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{1}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\renewcommand\thechapter{\@arabic\c@chapter}
\renewcommand\thesection{\thechapter.\@arabic\c@section}
\renewcommand\thesubsection{\thesection.\@arabic\c@subsection}
\newcommand\@chapapp{\chaptername}
\newcommand\appendix{%
  \printbibliography
  \uzl@bibliography@printedtrue
  \par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}




%%%
%
% Chapters
%
%%%

\newcommand\chapter{\clearpage
  \thispagestyle{plain}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{
  \refstepcounter{chapter}%
  \typeout{\@chapapp\space\thechapter.}%
  \addcontentsline{toc}{chapter}%
  {\protect\numberline{\thechapter}#1}%
  \chaptermark{#1}%
  \@makechapterhead{#2}{\uzl@chapternum}%
  \@afterheading}
\def\@schapter#1{
  \@makechapterhead{#1}{}%
  \@afterheading%
}
\def\uzl@chapternum{
  {%
    \UzLStyle{chapter number}%
    \UzLStyle{chapter number pre}%
    \thechapter%
    \UzLStyle{chapter number post}%
  }%
}
\def\@makechapterhead#1#2{%
  {%
    \normalfont%
    \rightskip 0pt plus1fil%
    \UzLStyle{chapter}%
    \UzLStyle{chapter pre}%
    \parindent \z@ 
    #2%
    \interlinepenalty\@M%
    #1\par\nobreak
    \UzLStyle{chapter post}%
  }%
}

\UzLStyle{
  %
  chapter number/.uzl style inherits from = structure,
  chapter number pre/.code = {},
  chapter number post/.code = {},
  %
  chapter/.uzl style inherits from = structure,
  chapter pre/.code = {},
  chapter post/.code = {},
}





%%%
%
% Sections
%
%%%

\newcommand\section{%
  \@startsection {section}%
  {1}% depth
  {\z@}% general indent
  {-4.25ex \@plus -1ex \@minus -.2ex}% pre skip
  {2.75ex \@plus.2ex}% post skip
  {%
    \normalfont\parindent0pt\leavevmode\UzLStyle{section font,section layout,section color}%
  }% font
}

\newif\ifuzl@is@sec

\UzLStyle{
  %
  section/.uzl style inherits from = structure,
  section font/.append code = \Large,
  section layout/.code = {%
    \rightskip 0pt plus1fil%
    \uzl@is@sectrue
    \uzl@sec@layout
  },
}

\let\uzl@sec@layout\relax
\def\uzl@centersec{%
  \leftskip5mm plus1fill%
  \rightskip5mm plus 1fill%
  \def\@hangfrom##1{\ifuzl@is@sec##1\@@par\nobreak\smallskip\nobreak\fi}%
}


%%%
%
% Subsections
%
%%%
                                 
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\parindent0pt\leavevmode\UzLStyle{subsection font,subsection layout,subsection color}}}

\UzLStyle{
  %
  subsection/.uzl style inherits from = section,
  subsection font/.append code = \large,
  subsection layout/.code = {%
    \rightskip 0pt plus1fil%
    \uzl@is@secfalse
    \uzl@sec@layout
  }
}




%%%%%%%%%%%%%%%%%%%%
%
% Table of contents (partly taken from report.cls)
%
%%%%%%%%%%%%%%%%%%%%
                                   
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em plus1fil}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{1}
\newcommand\tableofcontents{%
  \chapter*{\contentsname}
  \markright{\contentsname}%
  \@starttoc{toc}%
}
\newcommand*\l@chapter[2]{%
  \addpenalty{-\@highpenalty}%
  \vskip 1.5em \@plus\p@
  \setlength\@tempdima{1.5em}%
  \begingroup
    \UzLStyle{chapter in toc}
    \interlinepenalty\@M
    \parindent \z@
    \rightskip \@pnumwidth plus 1fil
    \parfillskip -\@pnumwidth
    \leavevmode
    \advance\leftskip\@tempdima
    \UzLStyle{format chapter toc line={#1}}%
    \UzLStyle{format chapter toc number={#2}}\par
    \penalty\@highpenalty
  \endgroup
}
\newcommand*\l@section{\uzl@sec@tocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\uzl@sec@tocline{2}{3.8em}{3.2em}}

\def\uzl@sec@tocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\@tocrmarg 
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \UzLStyle{section leaders}%
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}

\UzLStyle{
  chapter leaders/.code={\hfill},%\kern1ex\leaders\hrule\hfill},
  section leaders/.code={},
  chapter in toc/.uzl style inherits from = structure,
  section in toc/.uzl style inherits from = plain
}



%%%%%%%%%%%%%%%%%%%%
%
% Itemize and enumerate
%
%%%%%%%%%%%%%%%%%%%%
      
\setlength\leftmargini  {20pt}
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@arabic\c@enumii}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumi.\theenumii}
\renewcommand\p@enumii{\theenumi}
\newcommand\labelitemi{\normalfont \bfseries –}
\let\labelitemii\labelitemi
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep%
                                \UzLStyle{description}#1}


\UzLStyle{
  description/.uzl style inherits from = structure,
}


                              
\def\@listi{\leftmargin\leftmargini
            \listparindent.5\parindent
            \parsep 0\p@% \@plus2\p@ \@minus\p@
            \topsep 9\p@   \@plus3\p@ \@minus5\p@
            \itemsep0\p@% \@plus2\p@ \@minus\p@
          }
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    4.5\p@ \@plus2\p@ \@minus\p@
              \parsep    0\p@ %  \@plus\p@  \@minus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    2\p@ \@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \parsep}
\def\enumerate{%
  \ifnum \@enumdepth >1\uzl@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\let\endenumerate =\endlist
\newcount\@itemdepth \@itemdepth = 0
\def\itemize{%
  \ifnum \@itemdepth >1\uzl@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}}%
  \fi}

\def\uzl@toodeep{
  \ClassError{uzl-thesis}{%
    Nesting too deep!
    \MessageBreak 
    You can only nest enumerate and itemize 
    \MessageBreak 
    by two levels
  }
  {%
    The thesis class only allows you two levels of nesting.
    \MessageBreak
    Try rephrasing and restructuring the text.
    \MessageBreak
  }
}





%%%%%%%%%%%%%%%%%%%%
%
% Footnotes
%
%%%%%%%%%%%%%%%%%%%%
      
\renewcommand\footnoterule{%
  {\UzLStyle{structure color}\hrule\@width.333\textwidth height.8pt}
  \kern2.6\p@}
\newcommand\@makefntext[1]{%
  \leftskip 1em%
  \parindent 1em%
  \noindent%
  \hb@xt@0pt{\hss\@makefnmark\kern1pt}\ignorespaces#1}
% Unfortunately, due to a bug in hyperref, we need to hack into
% \footnote:
\let\uzl@orig@footnote\footnote
\def\footnote{\@ifnextchar[\uzl@footnote@opt\uzl@footnote}
\long\def\uzl@footnote@opt[#1]#2{\uzl@orig@footnote[#1]{\ignorespaces#2}}
\long\def\uzl@footnote#1{\uzl@orig@footnote{\ignorespaces#1}}



            
%%%%%%%%%%%%%%%%%%%%
%
% Arrays and equations
%
%%%%%%%%%%%%%%%%%%%%
      
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}


                              
%%%%%%%%%%%%%%%%%%%%
%
% Floats
%
%%%%%%%%%%%%%%%%%%%%

\newif\ifuzl@listoffigures
\newif\ifuzl@listoftables
               
\UzLThesisSetup{
  Abbildungsverzeichnis/.is if=uzl@listoffigures,
  Tabellenverzeichnis/.is if=uzl@listoftables
}
  
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}[1][\fps@figure]
               {\@float{figure}[#1]\small}
               {\end@float}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{1}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}[1][\fps@table]
               {\@float{table}[#1]\small}
               {\end@float}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{6\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\UzLStyle{float label}#1:} #2}%
  \ifdim \wd\@tempboxa >\hsize
    {{\UzLStyle{float label}#1:} #2\par}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\newcommand\listoffigures{%
    \chapter*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
      {\MakeUppercase\listfigurename}%
    {\def\numberline##1{\hbox to\uzl@toc@fig@width{\UzLStyle{float label}\figurename~##1\hss}}%
    \@starttoc{lof}}%
}
\newcommand*\l@figure{\uzl@sec@tocline{1}{0em}{\uzl@toc@fig@width}}
\newcommand\listoftables{%
    \chapter*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    {\def\numberline##1{\hbox to\uzl@toc@fig@width{\UzLStyle{float label}\tablename~##1\hss}}%
    \@starttoc{lot}%
    }}
\let\l@table\l@figure

\newdimen\uzl@toc@fig@width
\AtBeginDocument{%
  {%
    \setbox0=\hbox{\ifuzl@german Abbildung\else Figure\fi~XX.XX}%
    \global\uzl@toc@fig@width\wd0\relax%
    \global\advance\uzl@toc@fig@width by1em%
  }
}

\def\uzlhline{\noalign{\ifnum0=`}\fi\arrayrulewidth.8pt\UzLStyle{structure color}\hrule \@height \arrayrulewidth \futurelet \reserved@a\@xhline}
\def\uzlemph#1{{\leavevmode\UzLStyle{structure}#1}}
  
% Unify counters:
\let\c@table\c@figure
\let\cl@table\cl@figure
\let\p@table\p@figure
\let\thetable\thefigure
\def\ftype@table{1}

\UzLStyle{
  float label/.uzl style inherits from = structure,
}



%%%
%
% Math 
%
%%%

%
% Always use amsmath
%

\RequirePackage[fleqn]{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}


%
% Indent math twice the paragraph indent
%

\setlength{\mathindent}{2\parindent}


%
% Theorems and such
%

\theoremstyle{plain}
\newtheorem{theorem}{\uzlTheorem}[chapter]
\newtheorem{lemma}[theorem]{\uzlLemma}
\newtheorem{corollary}[theorem]{\uzlCorollary}
\newtheorem{conjecture}[theorem]{\uzlConjecture}
\newtheorem*{claim*}{\uzlClaim}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{\uzlDefinition}
\newtheorem{problem}[theorem]{\uzlProblem}
\newtheorem{fact}[theorem]{\uzlFact}
\newtheorem{example}[theorem]{\uzlExample}
\newtheorem*{example*}{\uzlExample}
\newtheorem{examples}[theorem]{\uzlExamples}
\newtheorem*{examples*}{\uzlExamples}
\newtheorem{counterexample}[theorem]{\uzlCounterexample}
\newtheorem*{counterexample*}{\uzlCounterexample}
\newtheorem{counterexamples}[theorem]{\uzlCounterexamples}
\newtheorem*{counterexamples*}{\uzlCounterexamples}

\theoremstyle{remark}
\newtheorem{observation}[theorem]{\uzlObservation}
\newtheorem*{observation*}{\uzlObservation}
\newtheorem{remark}[theorem]{\uzlRemark}
\newtheorem*{remark*}{\uzlRemark}

\thm@headfont{\UzLStyle{theorem font,theorem color}}

\UzLStyle{
  theorem/.uzl style inherits from = structure
}

\def\th@plain{%
  \thm@notefont{}
  \def\thmheadnl{\UzLStyle{theorem layout,theorem color}}
  \itshape % body font
}
\def\th@definition{%
  \thm@notefont{}
  \def\thmheadnl{\UzLStyle{theorem layout,theorem color}}
  \normalfont % body font
}
\def\th@remark{%
  \thm@notefont{}
  \thm@headfont{\UzLStyle{theorem font,theorem color}\upshape\mdseries\itshape}%
  \def\thmheadnl{\UzLStyle{theorem layout}}
  \normalfont % body font
  \thm@preskip\topsep \divide\thm@preskip\tw@
  \thm@postskip\thm@preskip
}


\ifuzl@english
  \def\uzlTheorem{Theorem}
  \def\uzlLemma{Lemma}
  \def\uzlCorollary{Corollary}
  \def\uzlDefinition{Definition}
  \def\uzlFact{Fact}
  \def\uzlObservation{Observation}
  \def\uzlRemark{Remark}
  \def\uzlConjecture{Conjecture}
  \def\uzlClaim{Claim}
  \def\uzlProblem{Problem}
  \def\uzlExample{Example}
  \def\uzlExamples{Examples}
  \def\uzlCounterexample{Counterexample}
  \def\uzlCounterexamples{Counterexamples}
\else
  \def\uzlTheorem{Satz}
  \def\uzlLemma{Hilfssatz}
  \def\uzlCorollary{Folgerung}
  \def\uzlDefinition{Definition}  
  \def\uzlFact{Fakt}
  \def\uzlObservation{Beobachtung}
  \def\uzlRemark{Bemerkung}
  \def\uzlConjecture{Vermutung}
  \def\uzlClaim{Behauptung}
  \def\uzlProblem{Problem}
  \def\uzlExample{Beispiel}
  \def\uzlExamples{Beispiele}
  \def\uzlCounterexample{Gegenbeispiel}
  \def\uzlCounterexamples{Gegenbeispiele}
\fi


\UzLStyle{
  %
  % Greek text in German
  %
  Greek theorem labels/.code={
    \ifuzl@german
      \def\uzlTheorem{Theorem}
      \def\uzlLemma{Lemma}
      \def\uzlCorollary{Korollar}
    \fi
  }
}

%%%
%
% Fonts 
%
%%%

\RequirePackage{fontspec}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

\newskip\uzl@latex@preskip \uzl@latex@preskip.36em
\newskip\uzl@latex@postskip \uzl@latex@postskip.15em

\DeclareRobustCommand{\LaTeX}{L\kern-\uzl@latex@preskip%
        {\sbox\z@ T%
         \vbox to\ht\z@{\hbox{\check@mathfonts
                              \fontsize\sf@size\z@
                              \math@fontsfalse\selectfont
                              A}%
                        \vss}%
        }%
        \kern-\uzl@latex@postskip%
        \TeX}


\newif\ifuzlfontfound
\def\uzlcheckfont#1#2#3#4{%
  \uzlfontfoundfalse
  \directlua{if kpse.find_file('#1', '#2') then  tex.print('\noexpand\\uzlfontfoundtrue') end}
  \ifuzlfontfound
  \else
    \ClassError{uzl-thesis}
    {%
      Font not found!
      \MessageBreak 
      I failed to find '#3'.
      \MessageBreak 
      Try installing package '#4'
    }
    {%
      I tried to load the file
      \MessageBreak
      '#1', but did not find it. 
      \MessageBreak
      This file contains the font '#3',
      \MessageBreak
      but does not seem to be installed.
      \MessageBreak
      Try installing the latex-package
      \MessageBreak
      #4.
      \MessageBreak
    }
  \fi
}

\def\uzlcheckmyriad{
  \uzlfontfoundfalse
  \directlua{if kpse.find_file('MyriadPro-Regular.otf', 'opentype fonts') 
             or kpse.find_file('Myriad Pro.ttf', 'truetype fonts') then  tex.print('\noexpand\\uzlfontfoundtrue') end}
  \ifuzlfontfound
  \else
    \ClassError{uzl-thesis}
    {%
      Lookup for Myriad font failed!
      \MessageBreak 
      I found neither 'MyriadPro-Regular.otf' nor
      \MessageBreak 
      'Myriad Pro.ttf' in a TeX directory.
      \MessageBreak
      You can get it from the university network at
      \MessageBreak
      /usr/share/fonts/truetype/adobe/Myriad Pro.ttf
      \MessageBreak
      Place it in some texmf directory!
    }
    {%
      I tried to find the Myriad Font, but did not.
      \MessageBreak
      You can get it from the university network at
      \MessageBreak
      /usr/share/fonts/truetype/adobe/Myriad Pro.ttf
      \MessageBreak
      Place it in some texmf directory, such as
      \MessageBreak
      the directory ~/texmf/fonts
      \MessageBreak
    }
  \fi
}
      
\newif\ifuzl@font@chosen
\let\ttfamilyinline\ttfamily

\UzLStyle{
  computer modern font/.code={
    \uzl@check@font
    \uzl@font@chosentrue
    \setmonofont{Latin Modern Mono Light}
    % Patch for modern versions of fontspec:
    \let\ttfamilyinline\relax
    \newfontfamily\ttfamilyinline{Latin Modern Mono Prop Light}
    % Adjust listing settings
  },
  pagella font/.code={
    \uzl@check@font
    \uzl@font@chosentrue
    \RequirePackage{unicode-math}
    \uzlcheckfont{texgyrepagella-regular.otf}{opentype fonts}{TeX Gyre Pagella}{tex-gyre or fonts-texgyre}
    \uzlcheckfont{texgyrepagella-math.otf}{opentype fonts}{TeX Gyre Pagella Math}{tex-gyre-math or fonts-texgyre}
    \uzlcheckfont{ClearSans-Regular.ttf}{truetype fonts}{Clear Sans}{clearsans}
    \setmainfont{TeX Gyre Pagella}
    \setmathfont{TeX Gyre Pagella Math}
    \setsansfont[Scale=0.95]{Clear Sans}
    \setmonofont[
      Scale=1.05,
      UprightFeatures={SmallCapsFont=LMMonoCaps10-Regular},
      ItalicFeatures={SmallCapsFont=LMMonoCaps10-Oblique},
      ]{Latin Modern Mono}
    % Patch for modern versions of fontspec:
    \let\ttfamilyinline\relax
    \newfontfamily\ttfamilyinline{Latin Modern Mono Prop}
    % Compensate for smaller font sizes
    \uzl@footnotesize   9.2pt
    \uzl@scriptsize     8.5pt
    \uzl@tiny           7pt
    % Adjust tikz settings:
    \tikzset{
      > = {Stealth[length=2.8pt .8, inset'=0pt .575, width'=0pt 1.55, line join=round, sep]},
      normal linewidth/.style = semithick,
    }
  },
  alegrya font/.code={
    \uzl@check@font
    \uzl@font@chosentrue
    \RequirePackage{unicode-math}
    \RequirePackage{Alegreya,AlegreyaSans}
    \setmonofont[
      Scale=1.025,
      UprightFeatures={SmallCapsFont=LMMonoCaps10-Regular},
      ItalicFeatures={SmallCapsFont=LMMonoCaps10-Oblique},
      ]{Latin Modern Mono}
    \uzlcheckfont{texgyrepagella-math.otf}{opentype fonts}{TeX Gyre Pagella Math}{tex-gyre-math or fonts-texgyre}
    \uzlcheckfont{texgyrechorus-mediumitalic.otf}{opentype fonts}{TeX Gyre Chorus}{tex-gyre or fonts-texgyre}
    \setmathfont{TeX Gyre Pagella Math}
    \setmathfont[Scale=1.1,range=\mathcal]{TeX Gyre Chorus}
    \setmathfont[Numbers=Lining,range=\mathup/{latin,Latin,num}]{Alegreya}
    \setmathfont[Numbers=Lining,range=\mathit/{latin,Latin,num}]{Alegreya Italic}
    \setmathfont[Numbers=Lining,range=\mathbfup/{latin,Latin,num}]{Alegreya Bold}
    \setmathfont[Numbers=Lining,range=\mathbfit/{latin,Latin,num}]{Alegreya Bold Italic}
    \setmathfont[range={\partial}]{Alegreya}
    % Patch for modern versions of fontspec:
    \let\ttfamilyinline\relax
    \newfontfamily\ttfamilyinline{Latin Modern Mono Prop}
    \newfontfamily\amslogofont[Scale=1.1,ItalicFont={TeX Gyre Chorus}]{TeX Gyre Chorus}
    \def\AmSfont{\amslogofont}
    % Compensate for different font scale:
    \uzl@Huge          27pt
    \uzl@huge          22pt
    \uzl@LARGE         18.5pt
    \uzl@Large         15.4pt 
    \uzl@large         13pt
    \uzl@normalsize    12pt
    \uzl@small         10.9pt
    \uzl@footnotesize  10pt
    \uzl@scriptsize     9.25pt
    \uzl@tiny           7.2pt
    \uzl@latex@preskip  .23em
    \uzl@latex@postskip .1em
    % Adjust tikz settings:
    \tikzset{
      > = {Stealth[length=2.8pt .8, inset'=0pt .575, width'=0pt 1.55, line join=round, sep]},
      normal linewidth/.style = semithick,
    }
  },  
}

\def\uzl@check@font{
  \ifuzl@font@chosen
    \ClassError{uzl-thesis}
      {%
        Double font selection!
        \MessageBreak 
        You can use only exactly one
        \MessageBreak 
        font selection key ('... als Schrift')
      }
      {%
        Use exactly one of the keys '... als Schrift'
        \MessageBreak
      }
  \fi
}


%%
%
% Varioref
%
%%

\RequirePackage{varioref}


%%
%
% Hyperref
%
%%

\RequirePackage[unicode,breaklinks,bookmarksnumbered,hidelinks]{hyperref}

\pdfstringdefDisableCommands{%  
  \let\UzLStyle\@gobble
}


%%%
%
% Language setup
%
%%%

\ifuzl@english
  \RequirePackage[german,main=english]{babel}
  \hypersetup{pdflang=en}
\else
  \RequirePackage[english,main=german]{babel}
  \hypersetup{pdflang=de}
\fi



%%%%%%%%%%%%%%%%%%%%%
%
% Document Info Setup
%
%%%%%%%%%%%%%%%%%%%%%

\UzLThesisSetup{
  %
  % Compulsory keys:
  %
  Titel auf Deutsch/.code=\uzl@storer#1\uzl@relax\uzl@title@german,
  Titel auf Englisch/.code=\uzl@storer#1\uzl@relax\uzl@title@english,
  Autor/.code=\uzl@storer#1\uzl@relax\uzl@author,
  Autorin/.forward to=/uzlthesissetup/Autor,
  Verfasst/.code 2 args=\def\uzl@institute{#2}\def\uzl@institute@am{#1},
  Betreuer/.code=\uzl@storer#1\uzl@relax\uzl@supervisor,
  Betreuerin/.forward to=/uzlthesissetup/Betreuer,
  Bachelorarbeit/.code=\def\uzl@degree{Bachelorarbeit},
  Masterarbeit/.code=\def\uzl@degree{Masterarbeit},
  Studiengang/.code=\uzl@storer#1\uzl@relax\uzl@programme,
  Datum/.code=\uzl@storer#1\uzl@relax\uzl@date,
  Abstract/.store in=\uzl@abstract,
  Zusammenfassung/.store in=\uzl@zusammenfassung,
  Danksagungen/.store in=\uzl@acknowledgements,
  Acknowledgements/.forward to=/uzlthesissetup/Danksagungen,
  %
  % Optional keys:
  %
  Mit Unterstützung von/.store in=\uzl@support@person,
  Weitere Unterstützung/.store in=\uzl@support@further,
  Schlüsselwörter/.store in=\uzl@keywords,
  Logo-Dateiname/.store in=\uzl@logo,
  Logo X Offset/.store in=\uzl@x@offset,
  Logo Y Offset/.store in=\ulz@y@offset,
}

\def\uzl@storer{\@ifnextchar\relax\uzl@@storer\uzl@@storer}
\def\uzl@@storer#1\uzl@relax#2{\def#2{#1}}
\def\uzl@missing@def#1#2{%
  \gdef#1{%
    \textcolor{red}{\normalfont \bfseries Missing \texttt{#2}!}%
  }%
}
\def\uzl@compulsory#1#2{%
  \def#1{%
    \uzl@missing@error{#2}%
    \uzl@missing@def{#1}{#2}%
    #1%
  }%
}

\uzl@compulsory\uzl@abstract{Abstract}
\uzl@compulsory\uzl@zusammenfassung{Zusammenfassung}
\let\uzl@acknowledgements\relax
\let\uzl@institute@am\relax
\uzl@compulsory\uzl@institute{Verfasst}
\let\uzl@title@german\relax
\let\uzl@title@english\relax
\let\uzl@author\relax
\uzl@compulsory\uzl@supervisor{Betreuer}
\let\uzl@degree\relax
\uzl@compulsory\uzl@programme{Studiengang}
\uzl@compulsory\uzl@date{Datum}
\let\uzl@support@person\relax
\let\uzl@support@further\relax
\let\uzl@keywords\relax

\let\uzl@logo\relax
\def\uzl@x@offset{1.34cm}
\def\uzl@y@offset{1.75cm}






%%%%%%%%%%%%%%%%%%%%%
%
% Content production
%
%%%%%%%%%%%%%%%%%%%%%


%%%
%
% Title page
%
%%%

\UzLStyle{
  %
  % The title page 
  %
  title page/.uzl style inherits from = plain,
  %
  % The title on the title page and the translated title
  %
  title on title page/.uzl style inherits from = structure,
  translated title on title page/.uzl style inherits from = title on title page,
  %
  % The other elements on the title page
  %
  element on title page/.uzl style inherits from = structure,
}

\def\uzl@make@titlepage{
  \pagenumbering{roman}  % but no page numbers are printed here because:
  \thispagestyle{empty}
  {
    \selectlanguage{german}
    \parindent0pt
    \parskip.25em
    {%
      \setbox0=\hbox{\kern-\uzl@x@offset\lower\uzl@y@offset\hbox{\includegraphics{\uzl@logo}}}%
      \wd0=0pt
      \ht0=5mm
      \dp0=2cm
      \leavevmode\box0
      \par
    }%
    \UzLStyle{title page}%
    \vfill
    {
      {\UzLStyle{title on title page}\ifuzl@german\foreignlanguage{german}{\ignorespaces\uzl@title@german}\else\foreignlanguage{english}{\ignorespaces\uzl@title@english}\fi\par}
      \medskip
      {\UzLStyle{translated title on title page}\ifuzl@german\foreignlanguage{english}{\ignorespaces\uzl@title@english}\else\foreignlanguage{german}{\ignorespaces\uzl@title@german}\fi\par}
    }%      
    \vskip2.5em
    {\UzLStyle{element on title page}\ignorespaces\uzl@degree}
    \par
    \vskip1.5em
    verfasst \uzl@institute@am\\
    {\UzLStyle{element on title page}\ignorespaces\uzl@institute}\par
    \par
    \vskip1.5em
    im Rahmen des Studiengangs\\
    {\UzLStyle{element on title page}\ignorespaces\uzl@programme}\\
    der Universität zu Lübeck\par
    \vskip1.5em
    vorgelegt von\\
    {\UzLStyle{element on title page}\ignorespaces\uzl@author}\par
    \vskip1.5em
    ausgegeben und betreut von\\
    {\UzLStyle{element on title page}\ignorespaces\uzl@supervisor}%
    \par
    \vskip1.5em
    \ifx\uzl@support@person\relax\else%
      mit Unterstützung von\\
      {\UzLStyle{element on title page}\ignorespaces\uzl@support@person}\par
      \vskip1.5em
    \fi
    \ifx\uzl@support@further\relax\else%
      \ignorespaces\uzl@support@further\par
    \fi
    \vfill
    \vfill
    Lübeck, den \ignorespaces\uzl@date\par
    \vskip-2em
    \raggedright
    \noindent\hfill{%
      \setbox0=\hbox{\lower2.1cm\hbox{\includegraphics{uzl-thesis-logo-slogan.pdf}}\kern-1.1cm}%
      \dp0=0pt%
      \box0%
    }%
    \clearpage
  }
}



%%%
%
% The blocks in the frontmatter
%
%%%

\UzLStyle{
  %
  % Blocks in the frontmatter
  %
  frontmatter block/.uzl style inherits from = plain,
  %
  % The headline of a frontmatter block
  %
  frontmatter block head/.uzl style inherits from = structure,
  %
  % 
  %
  frontmatter block head pre/.code={},
  frontmatter block head post/.code={},
}

\newenvironment{frontmatter block}[1]
{%
  \UzLStyle{frontmatter block}
  {%
    \UzLStyle{frontmatter block head pre}%
    \UzLStyle{frontmatter block head}%
    \noindent#1%
    \UzLStyle{frontmatter block head post}%
  }%
  \noindent\ignorespaces
}
{
  \par\vskip1em
}






%%%
%
% The frontmatter pages
%
%%%


\RequirePackage{etoolbox}

\AfterEndPreamble{
  \ifx\uzl@logo\relax%
    \def\uzl@logo{uzl-thesis-logo-uzl.pdf}%
  \fi%
  %
  %
  % Title Page
  %
  %
  \clearpage
  \uzl@make@titlepage%
  %
  %
  % Eidesstattliche Erklärung
  %
  %
  \pagestyle{plain}
  \leavevmode
  \vfill
  {
    \selectlanguage{german}
    \begin{frontmatter block}{Eidesstattliche Erklärung}
      \itshape
      Ich erkläre hiermit an Eides statt, dass ich diese Arbeit
      selbständig verfasst und keine anderen als die angegebenen Quellen
      und Hilfsmittel benutzt habe.
      \par\vskip3em
      {%
        \setbox0=\hbox{\normalfont\ignorespaces\uzl@author}%
        \hfill \vrule width5mm height.4pt\vrule width \wd0 height.4pt\vrule width5mm height.4pt\\
        \hbox{}\hfill \box0\kern5mm\par
      }
    \end{frontmatter block}
  }
  \vfill
  \vfill
  \clearpage
  % 
  %
  % Abstracts
  %
  %
  \leavevmode%
  \vfill
  \noindent\minipage{\textwidth}
    \parindent17pt
    \selectlanguage{german}
    \begin{frontmatter block}{Zusammenfassung}
      \uzl@zusammenfassung
    \end{frontmatter block}
  \endminipage%
  \vfill
  \vfill
  %
  %
  %
  \penalty-1
  \leavevmode
  \vfill
  \vfill
  \noindent\begin{minipage}{\textwidth}
    \parindent17pt
    \selectlanguage{english}
    \begin{frontmatter block}{Abstract}
      \uzl@abstract
    \end{frontmatter block}
  \end{minipage}%
  \vfill
  \vfill
  \vfill
  \vfill
  \clearpage
  \ifx\uzl@acknowledgements\relax%
  \else%
    \leavevmode
    \vfill
    \begin{frontmatter block}{\ifuzl@german Danksagungen\else Acknowledgements\fi}
      \uzl@acknowledgements
    \end{frontmatter block}
    \vfill
    \vfill
    \clearpage
  \fi
  \tableofcontents
  \ifuzl@listoffigures\listoffigures\fi
  \ifuzl@listoftables\listoftables\fi
  \clearpage
  \ifodd\c@page\else
    \hbox{}\clearpage
  \fi
  \setcounter{page}{1}
  \pagenumbering{arabic}
  \pagestyle{headings}
}



%%%
%
% Quoting stuff
%
%%%

\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\small\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\small\list{}{\rightmargin\leftmargin
                   \parsep        \z@
                 \listparindent 1.5em}%
                \item\relax}
               {\endlist}




%%%
%
% Bibliographies
%
%%%

\newif\ifuzl@bibliography@printed
               
\UzLThesisSetup{
  biblatex/.code=\expandafter\def\expandafter\uzl@biblatex@options\expandafter{\uzl@biblatex@options,#1},
  Alphabetische Bibliographie/.code={
    \uzl@load@biblatex{style=authoryear,dashed=false,uniquename=init}
    %
    % Till Tantau's code for reproducing the Cell bibliography style
    % in biblatex:
    %
    \DeclareNameAlias{sortname}{last-first}
    \setlength{\bibhang}{0pt}
    \setlength{\bibitemsep}{1em}
    \renewcommand*{\bibinitdelim}{}
    \renewbibmacro*{in:}{%
      \iffieldequalstr{entrytype}{inproceedings}{%
        \printtext{\bibstring{in}\addspace}%
      }{}%
    }
    \DeclareFieldFormat[book]{title}{##1\isdot}
    \DeclareFieldFormat[inproceedings]{title}{##1\isdot}
    \DeclareFieldFormat{booktitle}{##1\addcomma}
    \renewbibmacro*{byeditor+others}{%
      \ifnameundef{editor}
      {}
      {\printtext[parens]{%
          \printnames[paren]{editor}%
          \addcomma\addspace
          \usebibmacro{editorstrg}%
        }
        \setunit{\addspace}
        \newunit}%
      \usebibmacro{byeditorx}%
      \usebibmacro{bytranslator+others}}
    %
    \DeclareFieldFormat[article,inbook,incollection,inproceedings,patent,thesis,unpublished]{title}{##1}
    \DeclareFieldFormat[article]{journaltitle}{##1\isdot}
    \DeclareFieldFormat[article]{volume}{\textit{##1}}
    \DeclareFieldFormat[article]{pages}{##1}
    \renewbibmacro*{volume+number+eid}{\printfield{volume}}
    \renewcommand*{\nameyeardelim}{\addcomma\addspace}
    \DeclareCiteCommand{\cite}[\mkbibparens]
      {\usebibmacro{prenote}}
      {\usebibmacro{citeindex}%
        \usebibmacro{cite}}
      {\multicitedelim}
      {\usebibmacro{postnote}}
    \DeclareCiteCommand*{\cite}[\mkbibparens]
      {\usebibmacro{prenote}}
      {\usebibmacro{citeindex}%
        \usebibmacro{citeyear}}
      {\multicitedelim}
      {\usebibmacro{postnote}}
  },
  Numerische Bibliographie/.code={
    \uzl@load@biblatex{style=numeric}
    \DeclareNameAlias{sortname}{last-first}
    \DeclareNameAlias{author}{sortname}
    \DeclareNameAlias{editor}{sortname}
    \DeclareNameAlias{translator}{sortname}
    \DeclareFieldFormat[article]{pages}{##1}
    \DeclareFieldFormat[article,inbook,incollection,inproceedings,patent,thesis,unpublished]{title}{##1}
    \renewcommand*{\labelnamepunct}{\space\space}
    \renewbibmacro*{volume+number+eid}{%
      \printfield{volume}%
      \printfield[parens]{number}%
      \setunit{\adddot}%
      \printfield{eid}%
      \setunit{\addcolon}%
      \printfield{pages}%
    }
    \renewbibmacro*{note+pages}{%
      \printfield{note}%
      \newunit}
    \renewbibmacro*{issue+date}{%
      \setunit{\addcomma\space}%
      \iffieldundef{issue}
      {\usebibmacro{date}}
      {\printfield{issue}%
        \setunit*{\addspace}%
        \usebibmacro{date}}%
      \newunit%
    }%
  },
}

\def\uzl@biblatex@options{
  backend=bibtex,
  minbibnames=10,
  maxbibnames=10,
  firstinits=true
}

\newif\ifuzl@bibstyleset

\def\uzl@load@biblatex#1{
  \expandafter\RequirePackage\expandafter[\uzl@biblatex@options,#1]{biblatex}
  \uzl@bibstylesettrue
  \IfFileExists{\jobname-bibtex-entries.bib}{\addbibresource{\jobname-bibtex-entries.bib}}{}
  \defbibheading{bibliography}[\bibname]{%
    \chapter*{##1}%
    \addcontentsline{toc}{chapter}{##1}
    \markright{##1}%
    \sloppy
  }
}
\RequirePackage{csquotes}
\RequirePackage{url}

\def\UrlFont{\ttfamilyinline}
\def\url@ttstyle{\def\UrlFont{\ttfamilyinline}}


\AtEndPreamble{
  \ifuzl@bibstyleset
  \else
    \ClassError{uzl-thesis}
      {%
        Bibliography style not specified!
        \MessageBreak 
        You must use
        \MessageBreak 
        'Naturwissenschaftliche Bibliographie' or
        \MessageBreak 
        'Ingenieurwissenschaftliche Bibliographie' 
        \MessageBreak 
        in \string\UzLThesisSetup
      }
      {%
        Say \string\UzLThesisSetup{Naturwissenschaftliche Bibliographie} or
        \MessageBreak
        \string\UzLThesisSetup{Ingenieurwissenschaftliche Bibliographie} somewhere
        \MessageBreak
        in the preamble, depending on the study programme of your thesis
        \MessageBreak
      }
  \fi
}

\AtEndDocument{
  \ifuzl@bibliography@printed
  \else
    \printbibliography
  \fi
}

\RequirePackage{filecontents}

\newenvironment{bibtex-entries}{\filecontents{\jobname-bibtex-entries.bib}}{\endfilecontents}



%%%%%%%%%%%%%%%%%%%%
%
% Graphics
%
%%%%%%%%%%%%%%%%%%%%

\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning,shapes}


\tikzset{
  > = To[sep],
  normal linewidth/.style = thin,
  every picture/.style={normal linewidth},
  outer sep=auto,
  base shape/.style={
    thick,
    fill=white,
    draw=#1,
  },
  base shape/.default=uzlstructure,
  normalsize shape/.style={
    minimum size=7mm,
  },
  small shape/.style={
    font=\scriptsize,
    minimum size=5mm,
    inner sep=2pt,
  },
  block/.style={rectangle, base shape=#1, normalsize shape},
  block/.default=uzlstructure,
  small block/.style={block=#1, small shape},
  small block/.default=uzlstructure,
  node/.style={circle, base shape=#1, normalsize shape, inner sep=2pt},
  node/.default=uzlstructure,
  small node/.style={node=#1, small shape, inner sep=1pt},
  small node/.default=uzlstructure,
  tiny node/.style={node=#1, minimum size=1.75mm, inner sep=0pt},
  tiny node/.default=uzlstructure,
  structure/.style={color=uzlstructure},
  paper/.style={rectangle, fill=orange!50!yellow!8, draw=none},
}

\colorlet{emph}{red!75!black}

\colorlet{emph green}{green!50!black}
\colorlet{emph blue}{blue!90!black}
\colorlet{emph red}{red!75!black}
\colorlet{emph orange}{orange!75!black}

\colorlet{emph black}{black}

\tikzset{
  thesis outline shapes/.style={
    base shape/.style={
      thick,
      fill=white,
      draw=##1,
    }
  },
  thesis box shapes/.style={
    base shape/.style={
      thick,
      fill=##1!10,
      draw=##1,
    },
  },
  thesis flat shapes/.style={
    base shape/.style={
      draw=##1!10,
      fill=##1!10,
    },
  },
}



%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Listings and Algorithms
%
%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{listings}

% We hack into lstinline to add a new if

\let\uzl@lstinline\lstinline
\newif\ifuzl@lstinline
\def\lstinline{\kernel@ifnextchar[\uzl@lstinline@{\uzl@lstinline@[]}}
\def\uzl@lstinline@[#1]{\uzl@lstinline[@inline=,#1]}
\lst@Key{@inline}\relax{\uzl@lstinlinetrue}

% and to get the current style
\let\currentStyle@lstparam\relax
\lst@AddToHook{Output}{\global\let\currentStyle@lstparam\lst@thestyle}
\lst@AddToHook{OutputOther}{\global\let\currentStyle@lstparam\lst@thestyle}
\lst@AddToHook{OnNewLine}{\global\let\currentStyle@lstparam\relax}


\lstset{%
  basewidth={.5em,.45em},
  numbersep=1em,
  breaklines=true,
  breakatwhitespace=true,
  frame=lines,
  framerule=.8pt,
  rulecolor=\color{uzlstructure},
  numberstyle=\scriptsize,
  floatplacement=htpb,
  abovecaptionskip=10pt,
  belowcaptionskip=6pt,
}

\UzLStyle{
  code display/.code=\ttfamily\small,
  code inline/.code=\ttfamilyinline,
  code comment/.code=\color{black!60},
  code keyword/.code=\color{uzlstructure!50},
  code identifier/.code=,
  code string/.code=\color{uzlstructure},
  code emph/.code=\color{emph red}
}

\lstdefinelanguage{pseudocode}{
  morekeywords={
    algorithm,
    if,then,else,while,do,repeat,until,seq,
    seqdo,return,call,
    for,pardo,in,foreach,print,output,input,exit,
    break,loop,end,begin,goto,par,global,local,
    read,write,to,stop,idle,procedure,function,
    throw,catch
  },
  sensitive=true,
  morecomment=[l]{//},
  morestring=[b]",
  morestring=[s]{``}{''},
}

\lstdefinestyle{escapemath}{
  escapechar=$, %$
  escapebegin=\currentStyle@lstparam$,
  escapeend=$,
}

\lstdefinestyle{noescapemath}{
  escapechar=,
}

\lstdefinestyle{code}{
  basicstyle=\ifuzl@lstinline\UzLStyle{code inline}\else\UzLStyle{code display}\fi,
  commentstyle=\UzLStyle{code comment},
  keywordstyle=\UzLStyle{code keyword},
  identifierstyle=\UzLStyle{code identifier},
  stringstyle=\UzLStyle{code string},
  emphstyle=\UzLStyle{code emph},
  columns=fixed,
  style=noescapemath,
}

\lstdefinestyle{pseudocode}{
  language=pseudocode,
  basicstyle=\ifuzl@lstinline\UzLStyle{pseudocode inline}\else\UzLStyle{pseudocode display}\fi,
  commentstyle=\UzLStyle{pseudocode comment},
  keywordstyle=\UzLStyle{pseudocode keyword},
  emphstyle=\UzLStyle{pseudocode emph},
  identifierstyle=\UzLStyle{pseudocode identifier},
  stringstyle=\UzLStyle{pseudocode string},
  columns=fullflexible,
  style=escapemath,
  literate={<-}{{$\gets$\ }}2,
}

\newif\ifuzlincomment
\UzLStyle{
  pseudocode display/.code=\rmfamily,
  pseudocode inline/.code=\rmfamily,
  pseudocode comment/.code=\upshape\small\color{black!60},
  pseudocode keyword/.code=\color{uzlstructure!50}\itshape,
  pseudocode identifier/.code=\itshape,
  pseudocode string/.code=\color{uzlstructure}\rmfamily,
  pseudocode emph/.code=\color{emph red},
}

\lstdefinestyle{inline}{
  showspaces=true,
  columns=fullflexible
}

% Shorthands for common languages:
\newif\ifuzl@in@lst@env
\def\uzldeflanguageshorthand#1#2{
  \expandafter\newcommand\csname uzl@int@cmd@#1\endcsname[1][]{\lstinline[#2,style=inline,##1]}
  \lstnewenvironment{#1}[1][]{\uzl@in@lst@envtrue\lstset{#2,##1}}{}
  \expandafter\let\expandafter\uzl@temp\csname#1\endcsname
  \expandafter\let\csname uzl@int@env@#1\endcsname\uzl@temp
  \expandafter\edef\csname#1\endcsname{%
    \noexpand\ifuzl@in@lst@env%
      \noexpand\expandafter\noexpand\expandafter\noexpand\expandafter\expandafter\noexpand\csname uzl@int@cmd@#1\endcsname%
    \noexpand\else%
      \noexpand\ifx\noexpand\@currenvir\expandafter\noexpand\csname uzl@#1@text\endcsname%
        \noexpand\expandafter\noexpand\expandafter\noexpand\expandafter\expandafter\noexpand\csname uzl@int@env@#1\endcsname%
      \noexpand\else%
        \noexpand\expandafter\noexpand\expandafter\noexpand\expandafter\expandafter\noexpand\csname uzl@int@cmd@#1\endcsname%
      \noexpand\fi%
    \noexpand\fi%
  }
  \expandafter\def\csname uzl@#1@text\endcsname{#1}
}

\let\C\relax
\uzldeflanguageshorthand{Code}{style=code}
\uzldeflanguageshorthand{C}{style=code,language=c}
\uzldeflanguageshorthand{C++}{style=code,language=c++}
\uzldeflanguageshorthand{Cpp}{style=code,language=c++}
\uzldeflanguageshorthand{Java}{style=code,language=java}
\uzldeflanguageshorthand{Pseudocode}{style=pseudocode}
\uzldeflanguageshorthand{Latex}{style=code,language={[LaTeX]tex},moretexcs={chapter}}
\uzldeflanguageshorthand{Matlab}{style=code,language=Matlab}
\uzldeflanguageshorthand{Sql}{style=code,language=SQL}



%%%%%%%%%%%%%%%%%%%%%
%
% Final error checks
%
%%%%%%%%%%%%%%%%%%%%%

\def\uzl@missing@error#1{
  \ClassError{uzl-thesis}
    {%
      '#1' not configured!
      \MessageBreak 
      You must say \string\UzLThesisSetup[#1={...}]
    }
    {%
      '#1' is one of the compulsory keys that you must set.
      \MessageBreak
      Say \string\UzLThesisSetup[#1={...}] in your setup.
      \MessageBreak
    }%
}

\ifuzl@language@set
  \ifuzl@german
    \ifuzl@english
      \ClassError{uzl-thesis}
      {%
        Double language option!
        \MessageBreak 
        You cannot select both 'german' and 'english'.
        \MessageBreak 
        Add exactly one of them to \string\documentclass[...]
      }
      {%
        Your thesis must be written in German or English.
        \MessageBreak 
        You *must* indicate which language you use either saying
        \MessageBreak 
        \string\documentclass[german]{uzl-thesis} or saying
        \MessageBreak 
        \string\documentclass[english]{uzl-thesis}
        \MessageBreak 
      }
    \fi
  \fi  
\else
  \ClassError{uzl-thesis}
  {%
    Missing language option!
    \MessageBreak 
    You must select either 'german' or 'english'.
    \MessageBreak 
    Add exactly one of them to \string\documentclass[...]
  }
  {%
    Your thesis must be written in German or English.
    \MessageBreak 
    You *must* indicate which language you use either saying
    \MessageBreak 
     \string\documentclass[german]{uzl-thesis} or saying
    \MessageBreak 
     \string\documentclass[english]{uzl-thesis}
    \MessageBreak 
  }
\fi


\ifuzlversion@set
\else
  \ClassError{uzl-thesis}
  {%
    Missing version!
    \MessageBreak 
    You must say which version of uzl-thesis
    \MessageBreak 
    you use. Add 'version 2019' to \string\documentclass[...]
  }
  {%
    It is important that you specify which version of
    \MessageBreak 
    the class you wish to use. This way, an existing thesis 
    \MessageBreak 
    can still be typeset in the future when the class changes.
    \MessageBreak 
  }
\fi




%%%
%
% Late setup
%
%%%

%
% Check for complete specification
%

\newif\ifuzl@inst@setup

\AtBeginDocument{
  %
  \ifx\uzl@title@german\relax
    \uzl@missing@error{Titel auf Deutsch}
    \uzl@missing@def\uzl@title@german{Titel auf Deutsch}
  \fi
  %
  \ifx\uzl@title@english\relax
    \uzl@missing@error{Titel auf Englisch}
    \uzl@missing@def\uzl@title@english{Titel auf Englisch}
  \fi
  %
  \ifx\uzl@author\relax
    \uzl@missing@error{Autor}
    \uzl@missing@def\uzl@title@autor{Autor}
  \fi
  %
  \ifx\uzl@degree\relax
    \ClassError{uzl-thesis}
      {%
        Degree not specified!
        \MessageBreak 
        You must use 'Bachelorarbeit' or
        \MessageBreak 
        'Masterarbeit' in \string\UzLThesisSetup
      }
      {%
        Say \string\UzLThesisSetup{Bachelorarbeit} or
        \MessageBreak
        \string\UzLThesisSetup{Masterarbeit} somewhere
        \MessageBreak
        in the preamble  
        \MessageBreak
      }
  \fi
  \ifuzl@font@chosen
  \else
    \ClassError{uzl-thesis}
      {%
        No font or design selection!
        \MessageBreak 
        You must select a font, usually by
        \MessageBreak 
        selecting a design. Try saying 
        \MessageBreak
        \string\UzLStyle{alegrya modern design} 
      }
      {%
        You must select a font, using the \string\UzLStyle
        \MessageBreak 
        command. Normally, you do not direclty select a font,
        \MessageBreak
        but you select a design, which internally selects the font.
        \MessageBreak
        Try saying \string\UzLStyle{alegrya modern design} 
        \MessageBreak
        (or some other design) in the preamble of the thesis.
        \MessageBreak
      }
  \fi
}


%
% Setup pdf document
%

\AtBeginDocument{
  \hypersetup{pdfauthor=\uzl@author}
  \hypersetup{pdfcreator=LaTeX with uzl-thesis class}
  \ifuzl@german
    \hypersetup{pdftitle=\uzl@title@german}
  \else
    \hypersetup{pdftitle=\uzl@title@english}
  \fi
  \ifx\uzl@keywords\relax
  \else
    \hypersetup{pdfkeywords=\uzl@keywords}
  \fi
}






%%%
%
% Basic styling (not configured, normally)
%
%%%

\UzLStyle{
  frontmatter block layout/.code={
    \par\vskip1em
    \leftskip1.5\parindent
    \rightskip1.5\parindent
  },
  frontmatter block head post/.code=\par\medskip,
  title page font/.append code = \large,
  title on title page font/.append code = \Large,
  translated title on title page font/.append code = \itshape\mdseries,
  foot font/.append code=\upshape\small,
  head font/.append code=\small,
  head layout/.code=\leftskip 5mm plus 1fill\rightskip 5mm plus 1fill,
}










%%%
%
% Style choice
%
%%% 

%
% Possible fonts choices
%

\UzLStyle{
  thesis bold structure/.style={
    structure font/.code = \bfseries,    
    head and foot font/.code = ,
  },
  thesis sansserif structure/.style={
    structure font/.code = \sffamily,
    title page font/.code = \sffamily,
    head and foot font/.code = \sffamily,
  },
  thesis bold sansserif structure/.style={
    structure font/.code = \bfseries\sffamily,
    title page font/.code = \sffamily,
    head and foot font/.code = \sffamily,
  },
  thesis small caps structure/.style={
    structure font/.code = \scshape,    
    head and foot font/.code = \scshape,
    title on title page font/.append code = \LARGE,
    translated title on title page font/.append code = \rmfamily\itshape
  }
}


%
% Possible layout choices
%

\UzLStyle{
  %
  % Title page
  %
  title page left layout/.style={
    title page layout/.code={\leftskip0pt \rightskip0pt plus1fill},
  },
  title page centered layout/.style={
    title page layout/.code={\leftskip0pt plus1fill\rightskip0pt  plus1fill},
  },
  %
  % Frontmatter blocks
  %
  frontmatter block left layout/.style={
    frontmatter block head layout/.code={
      \rightskip 2cm plus 1fill
    }
  },
  frontmatter block centered layout/.style={
    frontmatter block head layout/.code={
      \leftskip1cm plus 1fill
      \rightskip1cm plus 1fill
    }
  },  
  %
  % Chapters
  %
  chapter left layout/.style={
    chapter font/.append code = \huge,
    chapter pre/.code = \vspace*{35\p@},
    chapter post/.code = \vspace*{35\p@},
    chapter number font/.append code = \fontsize{60}{60}\selectfont,
    chapter number pre/.code = ,% \par\nobreak \vskip 20\p@,
    chapter number post/.code = \par\nobreak \vskip 20\p@,
    chapter number color/.append code = \color{.!50},
  },
  chapter centered layout/.style={
    chapter layout/.code = \leftskip 5mm plus 1fill\rightskip 5mm plus1fill,
    chapter font/.append code = \huge,
    chapter pre/.code = \vspace*{35\p@},
    chapter post/.code = \vspace*{35\p@},
    chapter number font/.append code = \Huge,%\fontsize{60}{60}\selectfont,
    chapter number pre/.code = ,% \par\nobreak \vskip 20\p@,
    chapter number post/.code = \par\nobreak \vskip 20\p@,
    chapter number color/.style = structure color,% \color{.!50},
  },
  %
  % Sections
  %
  section left layout/.code = {\let\uzl@sec@layout\relax},
  section centered layout/.code = {\let\uzl@sec@layout\uzl@centersec},
  %
  % Toc
  %
  toc left layout/.style={
    format chapter toc line/.code={
      \leftskip3em%
      \def\numberline####1{\hbox to3em{####1\hss}}%
      \hskip -\leftskip
      ##1\nobreak
      \UzLStyle{chapter leaders}\nobreak
    },
    format chapter toc number/.code=\hb@xt@\@pnumwidth{\hss ##1}\smallskip,
    /utils/exec=\renewcommand*\l@section{\uzl@sec@tocline{1}{0em}{3em}}
  },
  toc tree layout/.style={
    format chapter toc line/.code={
      \hskip -\leftskip
      ##1\nobreak
      \UzLStyle{chapter leaders}\nobreak
    },
    format chapter toc number/.code=\hb@xt@\@pnumwidth{\hss ##1},
    /utils/exec=\renewcommand*\l@section{\uzl@sec@tocline{1}{1.5em}{2.3em}}
  },
  toc centered layout/.style={
    format chapter toc line/.code={
      \rightskip 1cm plus 1fil
      \leftskip 1cm plus 1fil
      \parfillskip 0cm
      \def\numberline####1{}%
      ##1\vskip.75em\nobreak    
    },
    format chapter toc number/.code={},
    /utils/exec=\renewcommand*\l@section{\uzl@sec@tocline{1}{0em}{2.3em}}
  },
  %
  % all
  %
  thesis left layout/.style={
    title page left layout,
    frontmatter block left layout,
    chapter left layout,
    section left layout,
  },
  thesis centered layout/.style={
    title page centered layout,
    frontmatter block centered layout,
    chapter centered layout,
    section centered layout,
  },
}


%
% Page number styling
%

\UzLStyle{
  % 
  thesis page number hyphen/.style={
    page number pre/.code={\textendash\space},
    page number post/.code={\space\textendash},
  },
  %
  thesis page number plain/.style={
    page number pre/.code={},
    page number post/.code={},
  }
}


%
% Section Leaders
%

\UzLStyle{
  dotted leaders/.style={
    section leaders/.code={%
      \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill%
    },
  },
  solid leaders/.style={
    section leaders/.code={%
      \kern1ex\textcolor{.!50}{\leaders\hrule\hfill}%
    },
  },
  empty leaders/.style={
    section leaders/.code={%
      \hfill%
    },
  }
}


%
% Miscellaneous
%

\definecolor{Ozeangruen}{cmyk}{1,0,.20,.78} % Color of UzL
\colorlet{uzlstructure}{black}

\UzLStyle{
  thesis myriad title page/.style={
    /utils/exec=\uzlcheckmyriad,
    title page font/.code={\fontspec{MyriadPro}},
  },
  thesis colored structure/.style={
    /utils/exec=\colorlet{uzlstructure}{Ozeangruen},
    structure color/.code={\color{Ozeangruen}},
    element on title page color/.code={\color{black}}
  },
  thesis black and white structure/.style={
    /utils/exec=\colorlet{uzlstructure}{black},
    structure color/.code={},
    element on title page color/.code={},
    code comment/.code=\itshape,
    pseudocode comment/.code=\rmfamily,
    code keyword/.code=\bfseries\color{black!75},
    pseudocode keyword/.code=\bfseries\color{black!75}\itshape,
    code string/.code=\color{black!80},
    pseudocode string/.code=\color{black!80},
  },
  thesis theorem newline/.style={
    theorem layout/.code=\newline
  },
  thesis theorem inline/.style={
    theorem layout/.code=
  },
}



%
% Default choices
%

\UzLStyle{
  solid leaders,
  toc tree layout, 
  thesis left layout,
  thesis bold structure,
  thesis page number hyphen,
  thesis colored structure,
}



%
% Predefined designs
%

\UzLStyle{
  computer modern oldschool design/.style={
    computer modern font,
    thesis bold structure,
    thesis left layout,
    thesis black and white structure,
    toc tree layout,
    frontmatter block centered layout,
    dotted leaders,
    chapter number color/.code=,
  },
  computer modern basic design/.style={
    computer modern font,
    thesis bold structure,
    thesis left layout,
    thesis colored structure,
    thesis myriad title page,
    frontmatter block centered layout,
  },
  computer modern scholary design/.style={
    computer modern font,
    thesis small caps structure,
    thesis centered layout,
    thesis black and white structure,
    toc centered layout,
    dotted leaders,
    section font/.append code = \normalsize,
    subsection font/.append code = \normalsize,
    chapter number font/.append code = \huge
  },
  pagella basic design/.style={
    pagella font,
    thesis bold structure,
    thesis left layout,
    thesis colored structure,
  },
  pagella centered design/.style={
    pagella font,
    thesis bold structure,
    thesis centered layout,
    thesis colored structure,
    toc centered layout,
  },
  pagella contrast design/.style={
    pagella font,
    thesis bold sansserif structure,
    thesis left layout,
    thesis colored structure,
    toc left layout,
  },
  alegrya basic design/.style={
    alegrya font,
    thesis bold structure,
    thesis left layout,
    thesis colored structure,
  },
  alegrya scholary design/.style={
    alegrya font,
    thesis small caps structure,
    thesis centered layout,
    thesis black and white structure,
    dotted leaders,
    toc centered layout,
    code keyword/.code=\bfseries\color{black!60},
    pseudocode keyword/.code=\bfseries\color{black!50}\itshape,
  },
  alegrya stylish design/.style={
    alegrya font,
    thesis small caps structure,
    thesis centered layout,
    thesis colored structure,
    title page left layout,
    toc left layout,
  },
  alegrya modern design/.style={
    alegrya font,
    thesis sansserif structure,
    thesis left layout,
    thesis colored structure,
    toc left layout,
    element on title page font/.append code=\bfseries
  }
}







%%%
% 
% Thesis font
%
%
% Choosing a font for a thesis is a *very tricky subject*. You cannot
% just use a font that you think ``looks interesting'' by including
% some package. There are numerous reasons: First, a good font is a
% font that nobody notices (so it should be the opposite of
% an “interesting” font) since ``good typography is like good
% management: you *do not notice it*''. Second, in almost every thesis many
% different fonts are needed, especially in mathematical text. Very
% few packages install all the necessary symbols correctly, so
% choosing a font usually causes many problems in formulas, but often
% also in the main text. Third, changing the font may also change the
% length of the text considerably -- which is not desirable in the
% context of a thesis with an expected page count.
%
% For all of these reasons, you cannot freely choose the fonts you
% would like to use for your thesis. Rather, you must use one of the
% following options:
%
% \UzLStyle{alegrya font}
% \UzLStyle{computer modern font}
% \UzLStyle{pagella font}
%
% All three have been carefully setup by me to cover all mathematical
% text correctly (hopefully) and I have carefully adjusted the sizes
% to ensure that changing the font will only change the document
% length by a negligible amount. This means that you can freely choose
% any of the three options, but you may not use other font sets
% (unless your supervisor says otherwise and better check back with
% me...).
%
%
% There is one special key called
%
% \UzLStyle{thesis myriad title page}
%
% which, as the name suggests, will use the font “Myriad” for the
% title page (only). This font is the “Corporate Font” of the
% University of Lübeck (although the university is no corporation, oh
% well) and it looks quite nice on a title page. However, being a
% sansserif font, it is mainly appropriate for titles and will not
% be used in the main text. Also, it is not quite trivial to install
% this font (unlike the above fonts, which are preinstalled on your
% TeX system).
%
% For these reasons, the Myriad font option is only provided for the
% title page. To use it, if you do not have MyriadPro installed as a
% font, get it somewhere and put it in a directory where TeX can find
% it (the directory of your thesis will usually work nicely). Note
% that you *can* just copy the font from where ever you get it (like
% from your institute) since the university has licensed this font
% explicitly. 
%
%%%
%
% Structure font
%
%
% In a thesis there are many places where text is used to structure
% the text. This includes, of course, the title and
% actually most text on the title page, but also the headlines of
% chapters and section, texts like “Theorem” or “Lemma“ or “Figure“,
% or the lines in the bibliography.
%
% You can choose which font is used for these structural elements
% (more precisely, which series and shape; you cannot choose the
% family itself). There are several options:
%
%
% \UzLStyle{thesis bold structure}
%
% This is the default and uses the bold version of the main font (the
% normal serif font). This looks rather “traditional”.
%
%
% \UzLStyle{thesis sansserif structure}
%
% Use the sansserif version of the main font for all structural
% elements. This has a rather modern look, except when Computer Modern
% is used: Although all Computer Scientist really, really respect
% Donald Knuth, his sans serif version of computer modern is, well,
% just ugly...
%
%
% \UzLStyle{thesis bold sansserif structure}
%
% Use the bold version of sansserif version for structural elements. I
% think this is “a bit too much”, but if you like it, try it.
%
%
% \UzLStyle{thesis small caps structure}
%
% This is a very stylish option, especially in conjunction with a
% centered layout (see below). However, it really looks quite
% ”scholary” and not “modern” at all -- but, then, a thesis is,
% hopefully, a scholary text.
%
%
% In addition to the above, you can, in principle, configure the fonts
% used for each structural element separately. However, you should not
% do so and I will not explain how this is done -- with one exception:
% Since the title page often needs a different font, you may wish to
% say for instance
%
% \UzLStyle{title page font/.code = \sffamily}
%
% to change the font for the titlepage only. However, normally, you
% should not mess with this...
%
%%%
%
% Overall layout
%
%
% There are two basic layout options:
%
%
% \UzLStyle{thesis left layout}
%
% This is the default and “flushes” everything to the left, which is
% the default and a slightly more “modern“ layout.
%
%
% \UzLStyle{thesis centered layout}
%
% As the name suggests, most structural elements get centered. This is
% much more traditional layout, but also looks good with a modern sans
% serif font.
%
%
%%%
%
% Colors
%
% 
% You can say
%
% \UzLStyle{thesis colored structure}
%
% to cause all structural elements to be colored using the
% university's standard color (a greenish blue). The alternative
% (which is the default) is
%
% \UzLStyle{thesis black and white structure}
%
% Note that even when the structure is black and white, you can, of
% course, still use colors in your thesis. The university color is
% available as “Oceangruen”.
%
%
%%% 
%
% Table of contents
%
%
% The layout of the table of contents is a bit special and not
% governed by the above general layout options: Rather, you have three
% special choices:
%
%
% \UzLStyle{toc left layout}
%
% This creates a pretty “strict” left layout in which all chapters and
% sections are flushed left. Fits nicely with modern fonts.
%
% 
% \UzLStyle{toc tree layout}
%
% This is the default layout in which sections are indented relative
% to the chapters, creating a treelike impression. Looks good with any
% font.
%
% 
% \UzLStyle{toc centered layout}
%
% Centers the chapter titles in the table of contents. This is
% \emph{very} scholary and a bit too much for my taste these days. 
%
%
% In addition to the above layouts questions, you can also configure
% which lines are used to connect the section titles to the page
% numbers (they are called “leaders“ in \TeX):
%
%
% \UzLStyle{solid leaders}
%
% Draws a solid line from the section title to the page number. Modern
% look and the default.
%
%
% \UzLStyle{dotted leaders}
%
% The classical way of using dotted lines to connect the titles to the
% page number. Especially appropriate in a more scholary layout.
%
%
%%%
%
% Theorems
%
%
% First, you must decide whether theorem titles (like 'Theorem 3.1')
% are on their own line or whether the theorem text follows on the
% same line (the default). To change this, use
%
% \UzLStyle{thesis theorem newline}
%
%
% Second, there is a special consideration for German text: 
% In German, a 'Theorem' is actually correctly called 'Satz' and a
% 'Lemma' is actually a 'Hilfssatz'. If you prefer instead the Greek
% words also in a German text, use
%
% \UzLStyle{Greek theorem labels}
%
% In a German thesis, this will cause {theorem} environments to use
% 'Theorem' rather than 'Satz', will cause {lemma} environments to use
% 'Lemma' rather than 'Hilfssatz' and will cause {corollary} to use
% 'Korollar' rather than 'Folgerung'. In an English thesis, this key
% has no effect.
% 
%%%%%%%







\RequirePackage{uzl-thesis-patches}





%%%%%%
%
% Compatibility
%
%%%%%%


\ifuzlversion@nineteenseven
  % Old spelling mistake:
  \UzLThesisSetup{
    Masterarbet/.code=\def\uzl@degree{Masterarbeit},
  }
  \uzl@normalsizeskip 14pt 
\fi



\endinput






