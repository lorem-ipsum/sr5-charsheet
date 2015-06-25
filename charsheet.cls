\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{charsheet}
    [2014/06/24 v0.01 Charsheet class (currently) for Shadowrun 5]

\LoadClass[a4paper]{article}

\ProcessOptions\relax
\RequirePackage[%
    margin=0mm,
    centering,
]{geometry}
\setlength{\parindent}{0pt}
\pagestyle{empty}
\RequirePackage{hyperref}
\hypersetup{%
    pdfborder = {0 0 0}
}

\RequirePackage{xcolor}
\definecolor{border}{rgb}{0.494117647059,0.0588235294118,0.0705882352941}
\definecolor{line}{RGB}{109,110,112}
\definecolor{font}{RGB}{39,36,37}
\definecolor{monitor}{RGB}{176,178,180}

\RequirePackage{fontspec}
\setmainfont[
    Ligatures=TeX,
    UprightFont={* Condensed Bold},
    ItalicFont={* Condensed Light Italic},
    BoldFont={* Condensed Bold},
%    BoldItalicFont={* Condensed Bold Oblique},
    ]{Open Sans}
\newfontfamily{\heading}
    [Ligatures=TeX]
    {Grishenko NBP}
\newfontfamily{\lightFont}[
    Ligatures=TeX,
    UprightFont={* Condensed Light},
    BoldFont={* Condensed Bold},
    ItalicFont={* Condensed Light Italic},
]{Open Sans}
\newfontfamily{\wide}[
    Ligatures=TeX,
    UprightFont={* Light},
    BoldFont={* Bold},
    ItalicFont={* Light Italic},
]{Open Sans}
\newcommand{\light}[1]{{\lightFont\color{line} #1}}

\RequirePackage{tikz}
\usetikzlibrary{fadings}
\usetikzlibrary{positioning}
\usetikzlibrary{arrows.meta}
\tikzset{%
    border/.style={draw=border, line width=.3mm},
    border end/.style={border, path fading=south},
    write/.style={draw=line, line width=.3mm},
    monitor border/.style={draw=line, line width=.3mm, color=border},
    monitor line/.style={draw=line, line width=.5mm, color=monitor},
}

\newcommand{\setnewlength}[2]{\newlength{#1}\setlength{#1}{#2}}

\RequirePackage{calc}
\newlength{\BoxWidth}
\newlength{\BoxSep}
\newlength{\TitleWidth}
\setlength{\BoxWidth}{95mm}
\setlength{\BoxSep}{3mm}

\setnewlength{\BoxInnerUpperMargin}{2mm}
\setnewlength{\BoxInnerBottomMargin}{2mm}
\setnewlength{\BoxTitleHeight}{4.5mm}
\setnewlength{\BoxInnerInnerMargin}{4mm}
\setnewlength{\BoxInnerOuterMargin}{4mm}
\setnewlength{\VerticalBoxDistance}{3mm}
\setnewlength{\ContentWidth}{\BoxWidth-\BoxInnerInnerMargin-\BoxInnerOuterMargin}
\setnewlength{\LineDistance}{4.5mm}
\setnewlength{\LineGap}{3mm}

\newenvironment{CharSheet}{%
    \color{font}
}{%
}

\newenvironment{CharSheetPage}{%
    \begin{tikzpicture}%
    \path[use as bounding box]
        (-.5*\textwidth,0mm) rectangle (.5*\textwidth,.\textheight);
    \node[anchor=north west] at (-.5*\textwidth,0mm)
    {\includegraphics[width=.6\textwidth]{Shadowrun-5-Schriftzug_1500x300px.png}};
    \node[anchor=north west,inner ysep=0pt] (notes) at (20mm,-18.8mm) {\heading NOTES};
    \node[anchor=north west,inner ysep=0pt] (player) at (20mm,-14.8mm) {\heading PLAYER};
    \node[anchor=north west,inner ysep=0pt] (charname) at (20mm,-10.8mm) {\heading CHARACTER};
    \node (end) at (.5*\BoxSep+\BoxWidth,0mm) {};
    \foreach \n in {notes,charname,player}
        \draw[line width=.3mm] (\n.south east) -| (\n.south east -| end);

    \setlength{\LeftBoxStart}{-30mm}
    \setlength{\RightBoxStart}{-30mm}
}{%
    \node[above]  at (0mm, 10mm-\textheight) {\footnotesize\color{line}
        \begin{tabular}{c}
            Shadowrun logo and content courtesy of Pegasus Games under
            license from Catalyst Game Labs and Topps Company, Inc.\\
            © 2014 Topps Company, Inc. All rights reserved. Shadowrun is a
            registered trademark of Topps Company, Inc.
%            Shadowrun-Logo und Inhalte mit freundlicher Genehmigung von Pegasus
%            Spiele unter Lizenz von Catalyst Game Labs und Topps Company, Inc.\\
%            © 2014 Toppy Company, Inc. Alle Rechte vorbehalten. Shadowrun ist eine
%            eingetragene Handelsmarke von Topps Company, Inc.
        \end{tabular}};%
\end{tikzpicture}%
\newpage
}

\newcommand{\BoxTitle}[1]{\heading \color{white} \MakeUppercase{#1}}
\newcommand{\DrawBoxTitleRight}[1]{% title
    \path[fill=border] (0mm,0mm) -- node[right] {\BoxTitle{#1}} ++(0mm,-\BoxTitleHeight)%
        -- ++(\TitleWidth,0mm) -- ++(7.5mm,0mm) -- ++(-7.5mm,\BoxTitleHeight) -- cycle (0mm,0mm);
}
\newcommand{\DrawBoxBorderRight}[1]{%height
    \path[border end] (0,-#1) -- ++(0mm,12mm)
        ++(\BoxWidth,0mm) -- ++(0mm,-12mm);
    \path[border] (0mm,0mm) -- ++(0mm,-#1+12mm) ++(\BoxWidth,0mm) --
        ++(0mm,#1-20.5mm) -- ++(-4mm,4mm) -- ++(-\BoxWidth+4mm,0mm);
}
\newcommand{\DrawBoxTitleLeft}[1]{% title
    \path[fill=border] (\BoxWidth,0mm) -- node[left] {\BoxTitle{#1}} ++(0mm,-\BoxTitleHeight)%
        -- ++(-\TitleWidth,0mm) -- ++(-7.5mm,0mm) --
        ++(7.5mm,\BoxTitleHeight) -- cycle (\BoxWidth,0mm);%
}
\newcommand{\DrawBoxBorderLeft}[1]{% height
    \path[border end] (\BoxWidth,-#1) -- ++(0mm,12mm) ++(-\BoxWidth,0mm) -- ++(0mm,-12mm);%
%    \path[border end] (-\BoxSep-\BoxWidth,#2-#3) -- ++(0mm,12mm);%
    \path[border] (\BoxWidth,0mm) -- ++(0mm,-#1+12mm) ++(-\BoxWidth,0mm) --
        ++(0mm,#1-20.5mm) -- ++(4mm,4mm) -- ++(\BoxWidth-4mm,0mm);
}

\newlength{\LeftBoxStart}
\newlength{\LeftBoxHeight}
\newlength{\RightBoxStart}
\newlength{\RightBoxHeight}
\newlength{\InBoxPosition}
\newenvironment{BoxLeft}[1]{%
    \begin{scope}[%
        xshift=-\BoxWidth-\BoxSep,
        yshift=\LeftBoxStart,
    ]
    \DrawBoxTitleLeft{#1}
    \setlength{\InBoxPosition}{-\BoxTitleHeight-\BoxInnerUpperMargin}
}{%
    \addtolength{\InBoxPosition}{-\BoxInnerBottomMargin}
    \DrawBoxBorderLeft{-\InBoxPosition}
    \addtolength{\LeftBoxStart}{\InBoxPosition-\VerticalBoxDistance}
    \global\LeftBoxStart=\LeftBoxStart
    \end{scope}
}
\newenvironment{BoxRight}[1]{%
    \begin{scope}[%
        xshift=\BoxSep,
        yshift=\RightBoxStart,
    ]
    \DrawBoxTitleRight{#1}
    \setlength{\InBoxPosition}{-\BoxTitleHeight-\BoxInnerUpperMargin}
}{%
    \addtolength{\InBoxPosition}{-\BoxInnerBottomMargin}
    \DrawBoxBorderRight{-\InBoxPosition}
    \addtolength{\RightBoxStart}{\InBoxPosition-\VerticalBoxDistance}
    \global\RightBoxStart=\RightBoxStart
    \end{scope}
}

\newenvironment{BoxRow}{%
}{%
    \addtolength{\InBoxPosition}{-\LineDistance}
    \global\InBoxPosition=\InBoxPosition
}

\newcommand{\Skip}[1]{\addtolength{\InBoxPosition}{-#1}\global\InBoxPosition=\InBoxPosition}

\newcommand{\SingleRow}[1]{#1 \Skip{\LineDistance}
}

\newcommand{\Line}[2]{% x, width
    \path[write] (\BoxInnerOuterMargin+#1, \InBoxPosition-\LineDistance) -- ++(#2,0mm);
}

\newcommand{\FullLine}{%
    \Line{0mm}{\ContentWidth}
}
\newcommand{\HalfLines}{%
    \Line{0mm}{.5*\ContentWidth-.5*\LineGap}
    \Line{.5*\ContentWidth+.5*\LineGap}{.5*\ContentWidth-.5*\LineGap}
}
\newcommand{\LabelAt}[3][right]{% x, label
    \node[base #1,inner sep=0pt] at (\BoxInnerOuterMargin+#2, \InBoxPosition-4mm)
        {\fontsize{7pt}{10.5pt}\selectfont #3};
}
\newcommand{\LabeledFullLine}[1]{%label
    \SingleRow{
        \FullLine
        \LabelAt{0mm}{#1}
    }
}
\newcommand{\EmptyFullLine}{%
    \SingleRow{\FullLine}
}

\setnewlength{\AttributeWidth}{15mm}
\newcommand{\Attribute}[2]{% x, attribute 
    \Line{#1}{\AttributeWidth}
    \Line{#1+\AttributeWidth+\LineGap}{.5*\ContentWidth-1.5*\LineGap-\AttributeWidth}
    \node[base left,inner sep=0pt] at (\BoxInnerOuterMargin+#1+\AttributeWidth, \InBoxPosition-4mm)
        {\fontsize{7pt}{10.5pt}\selectfont #2};
}
\newcommand{\AttributeLine}[2]{% left attribute, right attribute
    \SingleRow{%
        \Attribute{0mm}{#1}
        \Attribute{.5*\ContentWidth+.5*\LineGap}{#2}
    }
}

\newcommand{\ConditionMonitor}[4][]{% subcaption, x, rows, title
    \begin{scope}[xshift=\BoxInnerOuterMargin+#2,yshift=\InBoxPosition,scale=1.28]
        \node[above] at (1.5, 0) {#4};
        \foreach \i in {0,...,3} \draw[monitor border] (\i,0) -- (\i,-#3);
        \foreach \i in {0,...,#3} \draw[monitor border] (0,-\i) -- (3,-\i);
        \draw[monitor line, fill] (.5,-.5) circle[radius=.07];
        \foreach \i in {2,...,#3} 
            \draw[monitor line] (.5,1.5-1*\i) -- ++(2,0) -- ++(-2,-1);
        \draw[monitor line, -{Stealth[]}] (.5,.5-1*#3) -- ++(2,0);
        \foreach \i in {1,...,#3}
        \node[above left] at (3,-\i)
            {\fontsize{12pt}{18pt}\color{line}\selectfont -\i};
            \node[below] at (1.5,-#3)
            {\fontsize{7pt}{9pt}\light{\begin{tabular}{c}#1\end{tabular}}};
    \end{scope}
}

\endinput

% vim: filetype=tex