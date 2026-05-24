%%
%%
%%
%%          "LaTeX2e for class and package writers", 1995, 2006
%%
%%


\ProvidesClass{uncc_dissertation}[2007/08/01 Ver 0.90]
\NeedsTeXFormat{LaTeX2e}


%%
%%      Paper size options : A4 and Letter (Default:Letter)
%%

\def\@defaultpapersize{letterpaper}
\DeclareOption{a4}{\renewcommand{\@defaultpapersize}{a4paper}}
\DeclareOption{letter}{\renewcommand{\@defaultpapersize}{letterpaper}}


%%
%%      Font size options : 10pt, 11pt and 12pt (Default:11pt)
%%

\def\@defaultptsize{11pt}
\DeclareOption{10pt}{\renewcommand{\@defaultptsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\@defaultptsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\@defaultptsize}{12pt}}


%%
%%      Passing options to report.cls
%%

\PassOptionsToClass{openany}{report}
\ProcessOptions
\LoadClass[\@defaultptsize,\@defaultpapersize]{report}


%%
%%      Loading Packages and Basic Parameter Setting
%%

\usepackage{setspace}
\usepackage{amsmath, amssymb, amsfonts, amsthm}
\usepackage{graphicx}
\usepackage[all]{xypic}
\usepackage{texdraw}
\usepackage{multirow} 
\usepackage{indentfirst}
\usepackage{cite}
\usepackage[total={6in,9in},top=1.5in,left=1in,ignorehead,ignorefoot,headsep=0.15in]{geometry}

\pagestyle{headings}
\setlength{\parindent}{0.3in}
\renewcommand{\baselinestretch}{1}

%%
%%      Parameters
%%

\renewcommand{\title}[1]{\ifx\empty#1\else\gdef\@title{#1}\fi}
\renewcommand{\author}[1]{\ifx\empty#1\else\gdef\@author{#1}\fi}
\newcommand{\degree}[1]{\ifx\empty#1\else\gdef\@degree{#1}\fi}
\newcommand{\area}[1]{\ifx\empty#1\else\gdef\@area{#1}\fi}
\newcommand{\graduateyear}[1]{\ifx\empty#1\else\gdef\@graduateyear{#1}\fi}
\newcommand{\advisor}[1]{\ifx\empty#1\else\gdef\@advisor{#1}\fi}
\newcommand{\committeeone}[1]{\ifx\empty#1\else\gdef\@committeeone{#1}\fi}
\newcommand{\committeetwo}[1]{\ifx\empty#1\else\gdef\@committeetwo{#1}\fi}
\newcommand{\committeethree}[1]{\ifx\empty#1\else\gdef\@committeethree{#1}\fi}
\newcommand{\committeefour}[1]{\ifx\empty#1\else\gdef\@committeefour{#1}\fi}

%\renewcommand{\qed}{{\it Q.E.D.}}

\setlength{\floatsep}{0pt}
\renewcommand{\topfraction}{1.0}
\renewcommand{\textfraction}{0}

%%
%%      Title Page
%%

\renewcommand{\maketitle}{
    \begin{titlepage}\thispagestyle{empty}\setcounter{page}{1}
        \begin{center}
            \large\MakeUppercase{\@title} \\ \normalsize
            %\vskip 30\p@
            \vskip 40\p@
            by \\
            %\vskip 10\p@
            \vskip 12\p@
            {\@author} \\
            %\vskip 40\p@
            \vskip 55\p@
            A dissertation submitted to the faculty of \\
            the University of North Carolina at Charlotte \\
            in partial fulfillment of the requirements \\
            for the degree of {\@degree} in \\
            {\@area} \\
            \vskip 10\p@
            Charlotte \\
            \vskip 10\p@
            {\@graduateyear}
        \end{center}
        \null\vfill
        \noindent\null\hskip 2.8in Approved by:\hfill\\
        \vskip 15\p@
        \noindent\null\hskip 2.8in \hrulefill\\
        \noindent\null\hskip 2.8in {\@committeeone}\hfill\\
        \vskip 15\p@
        \noindent\null\hskip 2.8in \hrulefill\\
        \noindent\null\hskip 2.8in {\@committeetwo}\hfill\\
        \vskip 15\p@
        \noindent\null\hskip 2.8in \hrulefill\\
        \noindent\null\hskip 2.8in {\@committeethree}\hfill\\
        \vskip 15\p@
        \noindent\null\hskip 2.8in \hrulefill\\
        \noindent\null\hskip 2.8in {\@committeefour}\hfill\\
        \null
    \end{titlepage}
    \clearpage
    \relax
}


%%
%%      Copyright Page
%%

\newcommand{\makecopyright}{
    \pagenumbering{roman}
    \setcounter{page}{2}
    \null\vfill
    \begin{center}
        \copyright {\@graduateyear} \\
        {\@author} \\
        ALL RIGHTS RESERVED \\
    \end{center}
    %\vskip 0.00in \null
    \vskip 0.55in \null
    \clearpage
    \relax
}


%%
%%      Abstract
%%

\renewenvironment{abstract}{
    \begin{center}
        \renewcommand{\baselinestretch}{1}
        \MakeUppercase{Resumen} \\
        %\vskip 20\p@
        %\begin{singlespace}
            %\MakeUppercase{\@author}. {\@title}. \mbox{(Director de tesis: \MakeUppercase{Dr. \@advisor})}
        %\end{singlespace}
    \end{center}
    \vskip-0.25in\begingroup
        \begin{doublespace}
            \null\hskip0.3in
}{
        \end{doublespace}
        \clearpage
    \endgroup
    \vfill
    \relax
}


%%
%%      Acknowledgments
%%

\newenvironment{acknowledgments}{
    \begin{singlespace}
        \begin{center}
            \MakeUppercase{AGRADECIMIENTOS} \\
            \vskip 20\p@
        \end{center}
    \end{singlespace}
    \begin{doublespace}
        \begingroup
}{
    \clearpage
    \endgroup
    \end{doublespace}
    \relax
}


%%
%%      Table of Contents
%%

\renewenvironment{tableofcontents}{
    \clearpage
    \begin{singlespace}
        %% \setcounter{tocdepth}{1}  <--  How can indicate the depth ???
        \begin{center}
            \MakeUppercase{\'Indice} \\
            \vskip 20\p@
        \end{center}
    \end{singlespace}
   \@starttoc{toc}
    \clearpage
    \relax
}

\renewcommand{\numberline}[1]{{#1}\hskip0.06in\null}

\renewcommand*\l@part[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \setlength\@tempdima{15\p@}%
        \begingroup
            \begin{singlespace}
                \parindent \z@
                \vskip 5\p@
                \rightskip \@pnumwidth
                \parfillskip -\@pnumwidth
                \leavevmode
                \advance\leftskip73\p@
                \hskip -\leftskip
                \MakeUppercase{PART}%
                    \hskip0.25in\mbox{\begin{minipage}[t]{5in}\hskip-0.18in\raggedright\MakeUppercase{#1}\end{minipage}}
                \nobreak\hfil
                \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                \vskip 10\p@
            \end{singlespace}
            \penalty\@highpenalty
        \endgroup
    \fi
}

\renewcommand*\l@chapter[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \setlength\@tempdima{15\p@}%
        \begingroup
            \begin{singlespace}
                \parindent \z@
                \vskip 5\p@
                \rightskip \@pnumwidth
                \parfillskip -\@pnumwidth
                \leavevmode
                \advance\leftskip73\p@
                \hskip -\leftskip
                \MakeUppercase{Cap\'\i tulo}%
                    \hskip0.2in\mbox{\begin{minipage}[t]{4.73in}\hskip-0.18in\raggedright\MakeUppercase{#1}\end{minipage}}
                \nobreak\hfil
                \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                \vskip 10\p@
            \end{singlespace}
            \penalty\@highpenalty
        \endgroup
    \fi
}

\newcommand*\l@nochapter[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \setlength\@tempdima{15\p@}%
        \begingroup
            \begin{singlespace}
                \parindent \z@
                \vskip 5\p@
                \rightskip \@pnumwidth
                \parfillskip -\@pnumwidth
                \leavevmode
                \advance\leftskip\@tempdima
                \hskip -\leftskip
                \MakeUppercase{#1}
                \nobreak\hfil
                \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                \vskip 10\p@
            \end{singlespace}
            \penalty\@highpenalty
        \endgroup
    \fi
}

\renewcommand*\l@section[2]{%
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{23\p@}%
    \begingroup
        \begin{singlespace}
            \parindent \z@
            \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode
            \advance\leftskip48\p@
            \hskip -\leftskip
            \hskip 0.6in\mbox{\begin{minipage}[t]{5.15in}\hskip-0.28in\raggedright{#1}\end{minipage}}
            \nobreak\hfil
            \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \vskip 10\p@
        \end{singlespace}
        \penalty\@highpenalty
    \endgroup
}

\renewcommand*\l@subsection[2]{%
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{32\p@}%
    \begingroup
        \begin{singlespace}
            \parindent \z@
            \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode
            \advance\leftskip80\p@
            \hskip -\leftskip
            \hskip 1.0in\mbox{\begin{minipage}[t]{4.75in}\hskip-0.38in\raggedright{#1}\end{minipage}}
            \nobreak\hfil
            \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \vskip 10\p@
        \end{singlespace}
        \penalty\@highpenalty
    \endgroup
}

\renewenvironment{listoffigures}{
    \clearpage
    \addcontentsline{toc}{nochapter}{List of Figures}
    \begin{singlespace}
        \begin{center}
            {LIST OF FIGURES}\\
            \vskip 20\p@
        \end{center}
    \end{singlespace}
   \@starttoc{lof}
    \clearpage
    \relax
}

\renewcommand*\l@figure[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \setlength\@tempdima{27\p@}%
        \begingroup
            \begin{singlespace}
                \parindent \z@
                \rightskip \@pnumwidth
                \parfillskip -\@pnumwidth
                \leavevmode
                \advance\leftskip75\p@
                \hskip -\leftskip
                \MakeUppercase{FIGURE}
                \hskip 0.05in\mbox{\begin{minipage}[t]{5.0in}{#1}\end{minipage}}
                \nobreak\hfil
                \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                \vskip 10\p@
            \end{singlespace}
            \penalty\@highpenalty
        \endgroup
    \fi
}

\renewenvironment{listoftables}{
    \clearpage
    \addcontentsline{toc}{nochapter}{List of Tables}
    \begin{singlespace}
        \begin{center}
            {LIST OF TABLES}\\
            \vskip 20\p@
        \end{center}
    \end{singlespace}
   \@starttoc{lot}
    \clearpage
    \relax
}

\renewcommand*\l@table[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \setlength\@tempdima{27\p@}%
        \begingroup
            \begin{singlespace}
                \parindent \z@
                \rightskip \@pnumwidth
                \parfillskip -\@pnumwidth
                \leavevmode
                \advance\leftskip69\p@
                \hskip -\leftskip
                \MakeUppercase{TABLE}
                \hskip 0.05in\mbox{\begin{minipage}[t]{5.1in}{#1}\end{minipage}}
                \nobreak\hfil
                \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
                \vskip 10\p@
            \end{singlespace}
            \penalty\@highpenalty
        \endgroup
    \fi
}

\newenvironment{listofabbreviations}{
    \clearpage
    \addcontentsline{toc}{nochapter}{List of Abbreviations}
    \begin{singlespace}
        %% \setcounter{tocdepth}{1}  <--  How can indicate the depth ???
        \begin{center}
            \MakeUppercase{LIST OF ABBREVIATIONS} \\
            \vskip 20\p@
        \end{center}
    \end{singlespace}
   \@starttoc{loa}
    \clearpage
    \relax
}

\newcommand\refname{Bibiliograf\'\i a}
\renewenvironment{thebibliography}[1]{
    \chapter*{\refname}%
    \singlespace
    \@mkboth{}{}%

    \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m}
    {\def\@noitemerr
        {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist

}


%
%  Chapter, Section and Sub-section headings
%

\newcommand\textarea{
    \newpage
    \pagenumbering{arabic}
    \setcounter{page}{1}
}

\renewcommand \thepart {\@Roman\c@part}
\renewcommand\thechapter{\@arabic\c@chapter}
\renewcommand\thesection{\thechapter.\@arabic\c@section}
\renewcommand\thesubsection{\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}

\renewcommand\part{
    \if@openright
        \cleardoublepage
    \else
        \clearpage
    \fi
    \thispagestyle{empty}%
    \if@twocolumn
        \onecolumn
        \@tempswatrue
    \else
        \@tempswafalse
    \fi
    \null\vfil
    \secdef\@part\@spart
}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
        \refstepcounter{part}%
        \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
        \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {
        \centering
        \interlinepenalty \@M
        \normalfont
        \ifnum \c@secnumdepth >-2\relax
            \Large\bfseries \partname\nobreakspace\thepart
            \par
            \vskip 10\p@
        \fi
        \Large \bfseries #2\par
    }%
    \@endpart
}

\def\@spart#1{%
    {
        \centering
        \interlinepenalty \@M
        \normalfont
        \Large \bfseries #1\par
    }%
    \@endpart
}

\def\@endpart{
    \vfil\newpage
    \if@twoside
        \if@openright
            \null
            \thispagestyle{empty}%
            \newpage
        \fi
    \fi
    \if@tempswa
        \twocolumn
    \fi
}

\renewcommand\chapter{
    \if@openright\cleardoublepage\else\clearpage\fi
    \thispagestyle{empty}%
    \global\@topnum\z@
    \secdef\@chapter\@schapter
}

\def\@chapter[#1]#2{
    \ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter:}#2}%
    \else
        \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \@makechapterhead{#2}%
    \@afterheading
    \@mkboth{}{}%
}

\def\@schapter#1{
    \addcontentsline{toc}{nochapter}{#1}
    \@makesreferencehead{#1}%
    \@afterheading
}

\def\@makesreferencehead#1{%
    \newpage
    \begin{singlespace}
        \thispagestyle{empty}
        \begin{center}
            \MakeUppercase{#1}
        \end{center}
    \end{singlespace}
%%  \vskip 2\p@
    \doublespace
}

\def\@makechapterhead#1{%
    \newpage
    \null\vskip 30\p@
    \begin{singlespace}
        \thispagestyle{empty}
        \begin{center}
            \MakeUppercase{Cap\'\i tulo} \thechapter: \MakeUppercase{#1}
        \end{center}
    \end{singlespace}
    \doublespace
}

\renewcommand\section{%
    \@startsection{section}{1}{\z@}{-1.0ex \@plus -1ex \@minus -.2ex}{0.8ex \@plus .2ex}%
    {\normalfont}%
}

\renewcommand\subsection{%
    \@startsection{subsection}{2}{\z@}{-1.0ex\@plus -1ex \@minus -.2ex}{0.8ex \@plus .2ex}%
    {\normalfont}%
}

\renewcommand\subsubsection{%
    \@startsection{subsubsection}{3}{\z@}{-1.0ex\@plus -1ex \@minus -.2ex}{0.8ex \@plus .2ex}%
    {\normalfont}%
}

\newcommand\abbrev[2]{{#2}{ (#1)}\unc@addabbreviation{#1}{#2}}

\def\unc@addabbreviation#1#2{\protected@write\@auxout{\let\label\@gobble \let\index\@gobble \let\glossary\@gobble}{\string\@writefile{loa}{\protect\abbreviationline{#1}{#2}}}}

\def\abbreviationline#1#2{\noindent\makebox[1.5in][l]{#1} #2\newline}