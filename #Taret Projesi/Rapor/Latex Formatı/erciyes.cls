% Version 0.93 18.8.2015 


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\LoadClass[a4paper,oneside,onecolumn,12pt]{report}[1996/10/31]
\RequirePackage{ifthen}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{fancyhdr}
\RequirePackage[hang,labelsep=period]{caption}
\RequirePackage{calc}
\captionsetup [table]{position=top, aboveskip=5pt, belowskip=5pt}
\captionsetup [figure]{position=bottom, aboveskip=5pt, belowskip=5pt}

\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{report}}
\DeclareOption{final}{\PassOptionsToClass{final}{report}}
\DeclareOption{openright}{\PassOptionsToClass{openright}{report}}
\DeclareOption{openany}{\PassOptionsToClass{openany}{report}}

\DeclareOption{titlepage}{\ClassWarning{erciyes}{Title page always generated. Option ignored.}}
\DeclareOption{notitlepage}{\ClassWarning{erciyes}{Option 'notitlepage' not available for thesis.}}
\DeclareOption{twoside}{\ClassWarning{erciyes}{Option 'twoside' not available for thesis.}}
\DeclareOption{twocolumn}{\ClassWarning{erciyes}{Option 'twocolumn' not available for thesis.}}
\DeclareOption{landscape}{\ClassWarning{erciyes}{Option 'landscape' not available for thesis.}}
\DeclareOption{legalpaper}{\ClassWarning{erciyes}{Option 'legalpaper' not available for thesis.}}
\DeclareOption{a4paper}{\ClassWarning{erciyes}{Option 'a4paper' not available for this class.}}
\DeclareOption{a5paper}{\ClassWarning{erciyes}{Option 'a5paper' not available for this class.}}
\DeclareOption{executivepaper}{\ClassWarning{erciyes}{Option 'executivepaper' not available.}}
\DeclareOption{b5paper}{\ClassWarning{erciyes}{Option 'b5paper' not available for this class.}}
\DeclareOption{letterpaper}{\ClassWarning{erciyes}{Option 'letterpaper' superfluous. Ignored.}}
\DeclareOption{onecolumn}{\ClassWarning{erciyes}{Option 'onecolumn' superfluous.  Ignored.}}
\DeclareOption{oneside}{\ClassWarning{erciyes}{Option 'oneside' superfluous.  Ignored.}}

\ProcessOptions

%% Tablo ve Şekil başlıklarının düzeni için
%% \begin{table}
%%    \captionsetup{singlelinecheck=false,justification=raggedright,font=Large} %% Bu kod sadece örnektir.
%%    \caption{Bu dename tablosu}
%% \end{table}
%% Şeklinde kullanılabilir
%% Daha geniş bilgi için caption.pdf dosyalarına bakınız.
%% \shorthandoff{=} \shorthandon{=} grafiklerde

\lhead{}
\chead{}
\rhead{\thepage}
\lfoot{}
\cfoot{}
\rfoot{}
\renewcommand{\headrulewidth}{0pt}

%Heceleme için hyphenpenalty değerini küçültebilirsiniz. 
%Değer küçültükçe hecelemek isteyecek, değer büyükdükce hecelemekten kaçacaktır.

\hyphenpenalty=10000
\exhyphenpenalty=10000

\newlength{\ChapterUstenBosluk}
\setlength{\ChapterUstenBosluk}{30mm}

\newcommand{\sol}{\textquotedblleft}          %% Sol tırnak için tanımlandı
\newcommand{\sag}{\textquotedblright}         %% Sağ tırnak için tanımlandı orjinalleri biraz uzun gibi :)
\newcommand{\sagb}{\sag\space}                %% Sağ tırnak ve bir boşluk

\newlength{\mistixI}
\newlength{\mistixII}

\newlength{\LoFparskip}     %% List of Figure parskip 08-05-2006
\setlength{\LoFparskip}{0em}

\newlength{\LoTparskip}     %% List of Table parskip 08-05-2006
\setlength{\LoTparskip}{0em}

\newlength{\ToCparskip}     %% Table of Content parskip 08-05-2006
\setlength{\ToCparskip}{0em}

\newif\if@AppendixVar  %% Ekler Olsun mu?
\@AppendixVarfalse

\newif\if@itsaFEN           %% Fen / Sosyal Seçimi

\newif\if@SembolListesiVar  %% Sembol Listesi Olsun mu?
\@SembolListesiVarfalse

\newif\if@KisaltmalarVar  %% Sembol Listesi Olsun mu?
\@KisaltmalarVarfalse

\newif\if@TabloListesiVar   %% Tablo Listesi Olsun mu?
\@TabloListesiVartrue       %% Default = Var

\newif\if@SekilListesiVar   %% Sekil Listesi Olsun mu?
\@SekilListesiVartrue       %% Default = Var

\newif\if@ToCisDotted   %% ToC Noktalı / Noktasız
\@ToCisDottedfalse      %% Default = Noktasız

\newif\if@ChapterBoldToC %% ToC da BÖLÜM 1-2.. bold mu?
\@ChapterBoldToCtrue    %% Default = Bold Değil

\newif\if@DestekVar     %% İç Kapakta Destek var ise yazacak.
\@DestekVarfalse        %% Default = False

\newif\if@OnayDateVar   %% Onay Tarihi tezi yazan tarafından belirtilmiş mi? \onaydate{11/10/2004 gibi}
\@OnayDateVarfalse      %% Default = False

\newif\if@TesekkurVar   %% Teşekkür var mı?
\@TesekkurVarfalse      %% Default = False

\newif\if@JuriVar       %% Juri isimleri Girilmiş mi?
\@JuriVarfalse          %% Default = False

\newif\if@AuthorIkiVar       %% Yazar 2 isimleri Girilmiş mi?
\@AuthorIkiVarfalse          %% Default = False

\newif\if@AuthorUcVar       %% Yazar 3 isimleri Girilmiş mi?
\@AuthorUcVarfalse          %% Default = False

\newif\if@AuthorDortVar       %% Juri isimleri Girilmiş mi?
\@AuthorDortVarfalse          %% Default = False

\newif\if@itsaPhD       %% Doktora / Master ?
\@itsaPhDfalse          %% Default = Master...

\newcommand*{\TabloListesiYok}{\@TabloListesiVarfalse}

\newcommand*{\SekilListesiYok}{\@SekilListesiVarfalse}

\newcommand*{\ToCLineisDotted}{\@ToCisDottedtrue}

\newcommand*{\ToCChapterBold}{\@ChapterBoldToCtrue}

\newcommand{\th@StoreIn}[2]{\gdef#1{#2}}  %% Stores the second arg in the command specified by the first arg.

\newcommand*{\degree}[3]
    {
        \th@StoreIn{\th@fulldegree}{#1}
        \th@StoreIn{\th@degree}{#2}
        \th@StoreIn{\th@longdegree}{#3}
    }
    
\newcommand*{\turkdegree}[2]
    {
        \th@StoreIn{\th@turkfulldegree}{#1}
        \th@StoreIn{\th@turkdegree}{#2}
    }
    
\newcommand*{\MSc}{
        \@itsaPhDfalse
        \degree{M.Sc.}{M.Sc.}{Master of Science}             %% İngilizce Tanımlamalar
        \turkdegree{Yüksek Lisans}{Yüksek Lisans}}           %% Türkçe Tanımlamalar

\newcommand*{\PhD}{
        \@itsaPhDtrue
        \degree{Ph.D.}{Ph.D.}{Doctor of Philosophy}
        \turkdegree{Doktora}{Doktora}}

\renewcommand*{\author}[3]{
    \th@StoreIn{\th@isimsoyisim}{#1 #2}
    \th@StoreIn{\th@soyisimisim}{#2, #1}
    \th@StoreIn{\th@numaraBir}{#3}
}

\newcommand*{\authorIki}[3]{
	\@AuthorIkiVartrue
	\th@StoreIn{\th@isimsoyisimIki}{#1 #2}
	\th@StoreIn{\th@soyisimisimIki}{#2, #1}
	  \th@StoreIn{\th@numaraIki}{#3}
}

\newcommand*{\authorUc}[3]{
	\@AuthorUcVartrue
	\th@StoreIn{\th@isimsoyisimUc}{#1 #2}
	\th@StoreIn{\th@soyisimisimUc}{#2, #1}
	  \th@StoreIn{\th@numaraUc}{#3}
}

\newcommand*{\authorDort}[3]{
	\@AuthorDortVartrue
	\th@StoreIn{\th@isimsoyisimDort}{#1 #2}
	\th@StoreIn{\th@soyisimisimDort}{#2, #1}
	  \th@StoreIn{\th@numaraDort}{#3}
}

\newcommand*{\juri}[2]{
  \@JuriVartrue
  \th@StoreIn{\th@juribir}{#1}
  \th@StoreIn{\th@juriiki}{#2}
}

\newcommand{\teziyoneten}[1]{\th@StoreIn{\th@TeziYoneten}{#1}}
\newcommand{\BolumBaskani}[1]{\th@StoreIn{\th@ABDBaskani}{#1}}
\newcommand{\teziyonetenenglish}[1]{\th@StoreIn{\th@TeziYonetenenglish}{#1}}
\newcommand{\anabilimdali}[1]{\th@StoreIn{\th@AnaBilimDali}{#1}}
\newcommand{\anabilimdaliUpper}[1]{\th@StoreIn{\th@AnaBilimDaliUpper}{#1}}
\newcommand{\destek}[1]{\@DestekVarfalse\th@StoreIn{\th@Destek}{#1}}
\newcommand{\onaydate}[1]{\@OnayDateVartrue\th@StoreIn{\th@OnayDate}{#1}}

\newcommand{\enstitumuduru}[1]{\th@StoreIn{\th@EnstituMuduru}{#1}}

\newcommand{\enstitu}[2]{\th@StoreIn{\th@EnstituUpper}{#1}\th@StoreIn{\th@EnstituLower}{#2}}
\newcommand{\enstituenglish}[2]{\th@StoreIn{\th@EnstituUpperenglish}{#1}\th@StoreIn{\th@EnstituLowerenglish}{#2}}

\newcommand{\fen}{\@itsaFENtrue\enstitu{FEN BİLİMLERİ}{Fen Bilimleri}\enstituenglish{GRADUATE SCHOOL OF NATURAL AND APPLIED SCIENCES}{Graduate School of Natural and Applied Sciences}}
\newcommand{\sosyal}{\@itsaFENfalse\enstitu{SOSYAL BİLİMLER}{Sosyal Bilimler}\enstituenglish{SOSYAL BİLİMLER}{Sosyal Bilimler}}

\newcommand*{\th@titleFtSz}{\fontseries{b}\fontsize{16}{16}\selectfont}             %% Title Font Boyutu
%\newcommand*{\th@ToCTitleFtSz}{\fontfamily{cmr}\fontseries{b}\selectfont}                           %% Icindekiler Sayfasindaki Title Font Boyutu
\newcommand*{\th@titleAnaBilimDaliFtSz}{\fontseries{b}\fontsize{16}{16}\selectfont} %% Anabilimdalı Font Boyutu
\newcommand*{\th@DestekFtSz}{\fontseries{b}\fontsize{14}{14}\selectfont}            %% Destek Font Boyutu
\newcommand*{\th@HdFnt}{\fontfamily{cmr}\selectfont\bfseries}                       %% Başlıklar Kalın (Bold) olacak
\newcommand*{\th@ChSz}{\normalsize\fontsize{12}{12}\selectfont}                     %% Chapter Font Boyutu 
\newcommand*{\th@ScSz}{\normalsize\fontsize{12}{12}\selectfont}                     %% Section Font Boyutu

\renewcommand{\title}[1]{\th@StoreIn{\th@title}{#1}}
\newcommand{\titleenglish}[1]{\th@StoreIn{\th@titleenglish}{#1}}
\newcommand{\titleCase}[1]{\th@StoreIn{\th@titleCase}{#1}}
\renewcommand{\date}[1]{\th@StoreIn{\th@date}{#1}}
\newcommand{\dateenglish}[1]{\th@StoreIn{\th@dateenglish}{#1}}

%
% Satır arası genişliği kodları WinEdt'nin Örnek tezinden dönüştürülmüştür.
%
\newlength{\defbaselineskip}
\setlength{\defbaselineskip}{\baselineskip}
\newcommand{\setlinespacing}[1]{\setlength{\baselineskip}{#1 \defbaselineskip}}         %%\setlinespacing --> #1 * \defbaselineskip işlemini gerçekleştiriyor
%\newcommand{\doublespacing}{\setlength{\baselineskip}{2.0 \defbaselineskip}}            %%\doublespacing = 2*\defbaselineskip
%\newcommand{\singlespacing}{\setlength{\baselineskip}{\defbaselineskip}}                %%\singlespacing = 1*\defbaselineskip
%\let\doublespacing\relax
%\let\singlespacing\relax
\newcommand{\oneandonehalf}{\setlength{\baselineskip}{1.5 \defbaselineskip}}            %%\oneandonehalf = 1.5*\defbaselineskip

\newcommand{\LoFspacing}{\setlength{\baselineskip}{1.3 \defbaselineskip}}               %%\LoFspacing = 1.2*\defbaselineskip 08-05-2006
\newcommand{\LoTspacing}{\setlength{\baselineskip}{1.3 \defbaselineskip}}               %%\LoTspacing = 1.2*\defbaselineskip 08-05-2006
\newcommand{\ToCspacing}{\setlength{\baselineskip}{1.3 \defbaselineskip}}               %%\ToCspacing = 1.2*\defbaselineskip 08-05-2006

\newlength{\spacebeforechapterToC} % ToC 'da 1.BÖLÜM yazısından önceki boşluk
\setlength{\spacebeforechapterToC}{10pt}

\newlength{\spaceafterchapterToC} % ToC 'da 1.BÖLÜM yazısından sonraki boşluk (1.BÖLÜM ile BÖLÜM başlığı arasındaki boşluk.)
\setlength{\spaceafterchapterToC}{2pt}

%
% Sayfa yapısı tanımlanıyor...
%

\AtBeginDocument{
        \setlength{\voffset}{-5.4mm}
        \setlength{\hoffset}{14.6mm}
        \setlength{\oddsidemargin}{0mm}      %% Sayfa Solu = 1in(25.4 mm) + 14.6mm = 40 mm
        \setlength{\evensidemargin}{0mm}     %% Sayfa Sağı = 1in(25.4 mm) + 14.6mm = 40 mm
        \setlength{\topmargin}{0mm}          %% Sayfa Üstü = 1in(25.4) -5.4mm = 20 mm --> Sayfa Numarasına (Sayfa Başlığına) Kadar Olan Kısım
        \setlength{\headheight}{10.0mm}         %% Sayfa Başlığı (Numarası) = 10 mm
        \setlength{\headsep}{5.0mm}             %% Sayfa Başlığı ile Sayfa Metni Arası Boşluk
        \setlength{\textheight}{242mm}          %% Sayfa Metni Yüksekliği
        \setlength{\textwidth}{150mm}           %% Sayfa Metni Genişliği
        \setlength{\marginparsep}{0mm}
        \setlength{\marginparwidth}{0mm}
        \setlength{\leftmargini}{1.25em}
        \setlength{\leftmarginii}{2.2em}
        \setlength{\leftmarginiii}{2.2em}
        \setlength{\leftmarginiv}{2.2em}
        \setlength{\leftmarginv}{2.2em}
        \setlength{\leftmarginvi}{2.2em}
        \setlength{\leftmargin}{0mm}
        \setlength{\labelsep}{.5em}
        \setlength{\labelwidth}{1.5em}
        \setlength{\footskip}{0mm}
        \setlength{\topskip}{0mm}
        \setlength{\parindent}{0pt}             %% Paragrafların ilk satırlarının ne kadar içeri gireceği
        \setlength\parskip{10pt}
        \pagestyle{fancy}
        \markright{}
        \onecolumn
        \raggedbottom
        \normalsize
        \normalfont
        \oneandonehalf
        \setcounter{tocdepth}{5}
        \setcounter{secnumdepth}{10}            %% Bütün başlıklar numaralanacak
        }
        
\AtEndDocument{
	\th@ozgecmispage
}

\newcommand*{\th@ChapterStyle}{\th@HdFnt\th@ChSz}
\newcommand*{\th@SectionStyle}{\th@HdFnt\th@ScSz}
\newcommand*{\th@SubSectionStyle}{\th@HdFnt\th@ScSz}
\newcommand*{\th@OtherSecHeadStyles}{\th@HdFnt\th@ScSz}


\newcommand*{\th@DoChapCenter}{\centering}
\newcommand*{\th@ChapHead}[1]{\protect\th@ChapterStyle \protect\th@DoChapCenter #1}

\newcommand*{\chapternameToC}{\fontfamily{cmr}\normalsize\selectfont BÖLÜM\normalfont}
\newcommand*{\contentsnameToC}{\fontfamily{cmr}\normalsize\selectfont İÇİNDEKİLER\normalfont}
\newcommand*{\listtablenameToC}{\fontfamily{cmr}\normalsize\selectfont TABLOLAR LİSTESİ\normalfont}
\newcommand*{\listfigurenameToC}{\fontfamily{cmr}\normalsize\selectfont ŞEKİLLER LİSTESİ\normalfont}
\newcommand*{\abstractnameToC}{\fontfamily{cmr}\normalsize\selectfont ABSTRACT\normalfont}
\newcommand*{\onaynameToC}{\fontfamily{cmr}\normalsize\selectfont KABUL VE ONAY\normalfont}
\newcommand*{\uygunluknameToC}{\fontfamily{cmr}\normalsize\selectfont BİLİMSEL ETİĞE UYGUNLUK SAYFASI\normalfont}
\newcommand*{\yonergeyeToC}{\fontfamily{cmr}\normalsize\selectfont YÖNERGEYE UYGUNLUK SAYFASI\normalfont}
\newcommand*{\ozetnameToC}{\fontfamily{cmr}\normalsize\selectfont ÖZET\normalfont}
\newcommand*{\tesekkurnameToC}{\fontfamily{cmr}\normalsize\selectfont  ÖNSÖZ / TEŞEKKÜR\normalfont}
\newcommand*{\girisnameToC}{\fontfamily{cmr}\normalsize\selectfont GİRİŞ\normalfont}
\newcommand*{\ozgecmisnameToC}{\fontfamily{cmr}\normalsize\selectfont ÖZGEÇMİŞ\normalfont}
\newcommand*{\symbolnameToC}{\fontfamily{cmr}\normalsize\selectfont SEMBOLLER LİSTESİ\normalfont}
\newcommand*{\abbreviationnameToC}{\fontfamily{cmr}\normalsize\selectfont KISALTMALAR\normalfont}
\newcommand*{\appendixnameToC}{\fontfamily{cmr}\normalsize\selectfont EKLER\normalfont}
\newcommand*{\bibnameToC}{\fontfamily{cmr}\normalsize\selectfont KAYNAKLAR\normalfont}
\newcommand*{\preappendixname}{EK}

\def\prefacename{\th@ChapHead{ÖNSÖZ / TEŞEKKÜR}}%
\def\refname{\th@ChapHead{KAYNAKLAR}}%
\def\abstractname{\th@ChapHead{ÖZET}}%
\def\bibname{\th@ChapHead{KAYNAKLAR}}%
\def\chaptername{\th@ChapHead{BÖLÜM}}%
\def\appendixname{\th@ChapHead{EK}}%
\def\contentsname{\th@ChapHead{İÇİNDEKİLER}}%
\def\listfigurename{\th@ChapHead{ŞEKİLLER LİSTESİ}}%
\def\listtablename{\th@ChapHead{TABLOLAR LİSTESİ}}%
\def\indexname{\th@ChapHead{DİZİN}}%
\def\figurename{Şekil}%
\def\tablename{Tablo}%
\def\partname{\th@ChapHead{KISIM}}%
\def\glossaryname{\th@ChapHead{TERİMLER SÖZLÜĞÜ}}
\def\symbolname{\th@ChapHead{SEMBOLLER LİSTESİ}}
\def\abbreviationname{\th@ChapHead{KISALTMALAR}}

\newcommand*{\th@DefTheChapter}{\arabic{chapter}}
\newcommand*{\th@DefTheSection}{\th@DefTheChapter.\arabic{section}}
\newcommand*{\th@DefTheSubsection}{\th@DefTheSection.\arabic{subsection}}
\newcommand*{\th@DefTheSubsubsection}{\th@DefTheSubsection.\arabic{subsubsection}}
\newcommand*{\th@DefTheParagraph}{\th@DefTheSubsubsection.\arabic{paragraph}}

\renewcommand*{\thechapter}{\th@DefTheChapter}
\renewcommand*{\thesection}{\th@DefTheSection}
\renewcommand*{\thesubsection}{\th@DefTheSubsection}
\renewcommand*{\thesubsubsection}{\th@DefTheSubsubsection}
\renewcommand*{\theparagraph}{\th@DefTheParagraph}

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      #1 \nobreak
       \if@ToCisDotted
       \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
         mu$}
       \fi
      \hfil\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
  
\def\@tocline#1#2#3#4#5{%
  \vskip 10\p@
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \if@ToCisDotted
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
          mu$}
     \fi
     \hfill
     \nobreak
     \nobreak\hb@xt@\@pnumwidth{\hss\protect\bf#5}
     \par}%
  \fi}

\def\@toclinenonbold#1#2#3#4#5{%
  \vskip 10\p@
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \if@ToCisDotted
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
          mu$}
     \fi
     \hfill
     \nobreak
     \nobreak\hb@xt@\@pnumwidth{\hss#5}
     \par}%
  \fi}


\newcommand*\l@mistix{\@toclinenonbold{1}{5mm}{8mm}}
\newcommand*\l@fhmkyl{\@tocline{1}{5mm}{8mm}}
\renewcommand*\l@section{\@tocline{1}{5mm}{8mm}}
\renewcommand*\l@subsection{\@tocline{2}{10mm}{13mm}}
\renewcommand*\l@subsubsection{\@tocline{3}{15mm}{18mm}}
\renewcommand*\l@paragraph{\@tocline{4}{0mm}{4.1em}}
\renewcommand*\l@table{\@toclinenonbold{1}{0mm}{5.5em}}
\renewcommand*\l@figure\l@table

% \renewcommand*\l@section{\@tocline{1}{0mm}{4.1em}}
% \renewcommand*\l@subsection{\@tocline{2}{0mm}{4.1em}}
% \renewcommand*\l@subsubsection{\@tocline{3}{0mm}{4.1em}}
% \renewcommand*\l@paragraph{\@tocline{4}{0mm}{4.1em}}
% \renewcommand*\l@table{\@tocline{1}{0mm}{5.5em}}
% \renewcommand*\l@figure\l@table


%\newcommand*\l@mistix{\@tocline{1}{0mm}{0mm}}
%\renewcommand*\l@section{\@tocline{1}{0mm}{2.3em}}
%\renewcommand*\l@subsection{\@tocline{2}{0mm}{3.2em}}
%\renewcommand*\l@subsubsection{\@tocline{3}{0mm}{4.1em}}
%\renewcommand*\l@table{\@tocline{1}{0mm}{5.5em}}
%\renewcommand*\l@figure\l@table

% ***********************
%
%\renewcommand*{\theenumi}{\arabic{enumi}}
%\renewcommand*{\theenumii}{\alph{enumii}}
%\renewcommand*{\theenumiii}{\roman{enumiii}}
%\renewcommand*{\theenumiv}{\alph{enumiv}}
%\renewcommand*{\labelenumi}{(\theenumi)}
%\renewcommand*{\labelenumii}{(\theenumii)}
%\renewcommand*{\labelenumiii}{(\theenumiii)}
%\renewcommand*{\labelenumiv}{(\theenumiii.\theenumiv)}

\newcommand*{\th@title}{
    \ClassError{erciyes}{*** You must specify the TITLE of your thesis! ***}
    {Use the \protect\title{} command in the preamble.}}

\newcommand*{\th@titleenglish}{
    \ClassError{erciyes}{*** You must specify the ENGLISH TITLE of your thesis! ***}
    {Use the \protect\titleenglish{} command in the preamble.}}

\newcommand*{\th@titleCase}{
    \ClassError{erciyes}{*** You must specify the 'Title in Case Mode' of your thesis! ***}
    {Use the \protect\titleCase{} command in the preamble.}}

\newcommand*{\th@EnstituUpper}{
    \ClassError{erciyes}{*** You must specify the ENSTITU FEN-SOSYAL of your thesis! ***}
    {Use the \protect\fen or \protect\sosyal command in the preamble.}}

\newcommand*{\th@date}{
    \ClassError{erciyes}{*** You must specify the DATE of your thesis! ***}
    {Use the \protect\date{} command in the preamble.}}

\newcommand*{\th@dateenglish}{
    \ClassError{erciyes}{*** You must specify the DATE of your thesis! ***}
    {Use the \protect\dateenglish{} command in the preamble.}}

\newcommand*{\th@TeziYoneten}{
    \ClassError{erciyes}{*** You must specify the TEZIYONETEN of your thesis! ***}
    {Use the \protect\TeziYoneten{} command in the preamble.}}

\newcommand*{\th@ABDBaskani}{
    \ClassError{erciyes}{*** You must specify the ABD Baskani of your thesis! ***}
    {Use the \protect\ABDBaskani{} command in the preamble.}}

\newcommand*{\th@TeziYonetenenglish}{
    \ClassError{erciyes}{*** You must specify the TEZIYONETEN of your thesis! ***}
    {Use the \protect\TeziYonetenenglish{} command in the preamble.}}

\newcommand*{\th@isimsoyisim}{
        \ClassError{erciyes}{*** You must specify the AUTHOR of your thesis! ***}
        {Use the \protect\author{}{} command in the \MessageBreak
                preamble. The first arg is your first name and \MessageBreak
                middle initial.  The second arg is your last name.}}

\newcommand*{\th@turkfulldegree}{
        \ClassError{erciyes}{*** You must specify the degree of your thesis! ***}
        {Use the \protect\MSc or \protect\PhD command in the preamble.}}
        
\newcommand{\th@abstractStash}{
    \ClassError{erciyes}{*** You must specify an abstract! ***}
    {Use the \protect\abstractpage[]{} command in the \MessageBreak
        preamble.  If your abstract runs over a page, \MessageBreak
        use the optional argument with the word 'long'.}
}

\newcommand{\th@ozetStash}{
    \ClassError{erciyes}{*** You must specify an ozet! ***}
    {Use the \protect\ozetpage[]{} command in the \MessageBreak
        preamble.  If your abstract runs over a page, \MessageBreak
        use the optional argument with the word 'long'.}
}

\newcommand{\th@AnaBilimDali}{
    \ClassError{erciyes}{*** You must specify an AnaBilimDali! ***}
    {Use the \protect\anabilimdali[]{} command in the \MessageBreak
        preamble.  If your abstract runs over a page, \MessageBreak
        use the optional argument with the word 'long'.}
}

\newcommand{\th@EnstituMuduru}{
    \ClassError{erciyes}{*** You must specify an AnaBilimDali! ***}
    {Use the \protect\enstitumuduru[]{} command in the \MessageBreak
        preamble.  If your abstract runs over a page, \MessageBreak
        use the optional argument with the word 'long'.}
}


\newcommand{\th@AnaBilimDaliUpper}{
    \ClassError{erciyes}{*** You must specify an AnaBilimDali! ***}
    {Use the \protect\anabilimdaliUpper[]{} command in the \MessageBreak
        preamble.  If your abstract runs over a page, \MessageBreak
        use the optional argument with the word 'long'.}
}


\newcommand{\th@ozgecmisStash}{
    \ClassError{erciyes}{*** You must specify an ozgecmis ***}
    {Use the \protect\ozgecmispage[]{} command in the \MessageBreak
        preamble.  If your abstract runs over a page, \MessageBreak
        use the optional argument with the word 'long'.}
}

\renewcommand{\abstract}[1]{\th@StoreIn{\th@abstractStash}{#1}}
\newcommand{\ozet}[1]{\th@StoreIn{\th@ozetStash}{#1}}
\newcommand{\ozgecmis}[1]{\th@StoreIn{\th@ozgecmisStash}{#1}}
\newcommand{\tesekkur}[1]{\@TesekkurVartrue\th@StoreIn{\th@tesekkurStash}{#1}}
\newcommand{\giris}[1]{\th@StoreIn{\th@girisStash}{#1}}
\newcommand{\sembollistesi}[1]{\@SembolListesiVartrue\th@StoreIn{\th@symbollistStash}{#1}}
\newcommand{\kisaltmalar}[1]{\@KisaltmalarVartrue\th@StoreIn{\th@KisaltmalarStash}{#1}}

\def\section{\@ifstar\unnumberedsection\numberedsection}
\def\numberedsection{\@ifnextchar[%]
  \numberedsectionwithtwoarguments\numberedsectionwithoneargument}
\def\unnumberedsection{\@ifnextchar[%]
  \unnumberedsectionwithtwoarguments\unnumberedsectionwithoneargument}
\def\numberedsectionwithoneargument#1{\numberedsectionwithtwoarguments[#1]{#1}}
\def\unnumberedsectionwithoneargument#1{\unnumberedsectionwithtwoarguments[#1]{#1}}
\def\numberedsectionwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
  \vspace*{15pt}\goodbreak
  \refstepcounter{section}%
  \noindent
  \leavevmode
  \begingroup
  \th@HdFnt\th@ScSz
  \hspace{-0.75em}
  \begin{tabular}{ll} 
  \thesection.\ & \parbox[t]{\textwidth - \widthof{\thesection.\ } - 1em}{#2}
  \end{tabular}
  \endgroup\goodbreak
  \setlength{\mistixI}{\widthof{#2}}
  \setlength{\mistixII}{\textwidth - \widthof{\thesection.\ }}
  \ifthenelse{\mistixI > \mistixII}{\vspace{1em}}{}
  %\ifthenelse{\widthof{#2} > {\textwidth - \widthof{\thesection.\ }}}{\vspace{1cm}}{\vspace{0cm}}
  \addcontentsline{toc}{section}{\protect\bf\protect\numberline{\thesection.}\protect\bf #1}}
\def\unnumberedsectionwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
  \vspace*{15pt}\goodbreak
  \noindent
  \leavevmode
  \begingroup
  \bfseries
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{section}{\protect\bf #1}}
    
\def\subsection{\@ifstar\unnumberedsubsection\numberedsubsection}
\def\numberedsubsection{\@ifnextchar[%]
  \numberedsubsectionwithtwoarguments\numberedsubsectionwithoneargument}
\def\unnumberedsubsection{\@ifnextchar[%]
  \unnumberedsubsectionwithtwoarguments\unnumberedsubsectionwithoneargument}
\def\numberedsubsectionwithoneargument#1{\numberedsubsectionwithtwoarguments[#1]{#1}}
\def\unnumberedsubsectionwithoneargument#1{\unnumberedsubsectionwithtwoarguments[#1]{#1}}
\def\numberedsubsectionwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
   \vspace*{15pt}\goodbreak
  \refstepcounter{subsection}%
  \noindent
  \leavevmode
  \begingroup
  \th@HdFnt\th@ScSz
  \thesubsection.\ 
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{subsection}{\protect\bf\protect\numberline{\thesubsection.}\protect\bf #1}}
\def\unnumberedsubsectionwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
  \vspace*{15pt}\goodbreak
  \noindent
  \leavevmode
  \begingroup
  \bfseries
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{subsection}{\protect\bf #1}}

\def\subsubsection{\@ifstar\unnumberedsubsubsection\numberedsubsubsection}
\def\numberedsubsubsection{\@ifnextchar[%]
  \numberedsubsubsectionwithtwoarguments\numberedsubsubsectionwithoneargument}
\def\unnumberedsubsubsection{\@ifnextchar[%]
  \unnumberedsubsubsectionwithtwoarguments\unnumberedsubsubsectionwithoneargument}
\def\numberedsubsubsectionwithoneargument#1{\numberedsubsubsectionwithtwoarguments[#1]{#1}}
\def\unnumberedsubsubsectionwithoneargument#1{\unnumberedsubsubsectionwithtwoarguments[#1]{#1}}
\def\numberedsubsubsectionwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
   \vspace*{15pt}\goodbreak
  \refstepcounter{subsubsection}%
  \noindent
  \leavevmode
  \begingroup
  \th@HdFnt\th@ScSz
  \thesubsubsection.\ 
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{subsubsection}{\protect\bf\protect\numberline{\thesubsubsection.}\protect\bf #1}}
\def\unnumberedsubsubsectionwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
  \vspace*{15pt}\goodbreak
  \noindent
  \leavevmode
  \begingroup
  \bfseries
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{subsubsection}{\protect\bf #1}}

\def\paragraph{\@ifstar\unnumberedparagraph\numberedparagraph}
\def\numberedparagraph{\@ifnextchar[%]
  \numberedparagraphwithtwoarguments\numberedparagraphwithoneargument}
\def\unnumberedparagraph{\@ifnextchar[%]
  \unnumberedparagraphwithtwoarguments\unnumberedparagraphwithoneargument}
\def\numberedparagraphwithoneargument#1{\numberedparagraphwithtwoarguments[#1]{#1}}
\def\unnumberedparagraphwithoneargument#1{\unnumberedparagraphwithtwoarguments[#1]{#1}}
\def\numberedparagraphwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
   \vspace*{15pt}\goodbreak
  \refstepcounter{paragraph}%
  \noindent
  \leavevmode
  \begingroup
  \th@HdFnt\th@ScSz
  \theparagraph.\ 
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{paragraph}{\protect\bf\protect\numberline{\theparagraph.}\protect\bf #1}}
\def\unnumberedparagraphwithtwoarguments[#1]#2{%
  \ifhmode\par\fi
  \removelastskip
  \vspace*{15pt}\goodbreak
  \noindent
  \leavevmode
  \begingroup
  \bfseries
  #2\quad
  \endgroup\goodbreak
  \addcontentsline{toc}{paragraph}{\protect\bf #1}}
            %
            %\let\th@OldAppCmd\appendix
            %\renewcommand\appendix{
            %	\@AppendixVartrue\clearpage
            %%	\setcounter{th@AppendixCounter}{0}
            %	%\addtocontents{toc}{\protect\addvspace{10\p@}}
            %	%\if@ChapterBoldToC
            %	%\addcontentsline{toc}{section}{\protect\textbf{\appendixnameToC}}
            %	%\else
            %	%\setcounter{th@SectionSave}{\value{section}}
            %	\th@OldAppCmd
            %	\def\thechapter{\preappendixname-\arabic{chapter}}
            %	\captionsetup[table]{listof=false}
            %	\captionsetup[longtable]{listof=false}
            %	\captionsetup[figure]{listof=false}
            %	\addcontentsline{toc}{section}{\protect\bf\appendixnameToC}
            %	%\fi
            %	%\addcontentsline{toc}{mistix}{#1}
            %}
            %

\let\th@OldAppCmd\appendix
\renewcommand\appendix{
    \@AppendixVartrue
%   \setcounter{th@AppendixCounter}{0}
    %\addtocontents{toc}{\protect\addvspace{10\p@}}
    %\if@ChapterBoldToC
    %\addcontentsline{toc}{section}{\protect\textbf{\appendixnameToC}}
    %\else
    %\setcounter{th@SectionSave}{\value{section}}
    \addcontentsline{toc}{fhmkyl}{\protect\bf\appendixnameToC}
    \th@OldAppCmd
    \def\thechapter{\preappendixname-\arabic{chapter}}
    \captionsetup [table]{listof=false}
    \captionsetup [figure]{listof=false}
    %\fi
    %\addcontentsline{toc}{mistix}{#1}
}

\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                      \global\@topnum\z@
                      \@afterindentfalse
                      \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
			\if@AppendixVar\else
                          \addtocontents{toc}{\protect\addvspace{\spacebeforechapterToC}}%
                          \if@ChapterBoldToC
                          %\addtocontents{toc}{\protect\addvspace{\spacebeforesection}}%
                          %\addtocontents{toc}{\protect\centering\bf\thechapter. \protect\bf\chapternameToC \\}
                          %\addtocontents{toc}{\protect\addvspace{2\p@}}%
			  %\addtocontents{toc}{\protect\parbox{\protect\textwidth}{\protect\centering\protect\bf #1}}
			  %\addtocontents{toc}{\protect\parbox{\protect\textwidth}{\protect\centering\thechapter. \protect\bf\chapternameToC \protect\newline \protect\addvspace{2\p@} \protect\centering\protect\bf #1}}
			  \addtocontents{toc}{\protect\parbox{\protect\textwidth}
			  {\protect\centering\protect\bf\thechapter. \protect\bf\chapternameToC \protect\\ \protect\addvspace{\spaceafterchapterToC} \protect\bf #1}
			  }
                          \else
                          %\addtocontents{toc}{\protect\centering\thechapter. \protect\chapternameToC \\}
                          %\addtocontents{toc}{\protect\addvspace{2\p@}}%
			  %\addtocontents{toc}{\protect\parbox{\protect\textwidth}{\protect\centering\thechapter. \protect\bf\chapternameToC \protect\newline \protect\addvspace{2\p@} \protect\centering #1}}
			  \addtocontents{toc}{\protect\parbox{\protect\textwidth}
			  {\protect\centering\protect\thechapter. \protect\chapternameToC \protect\\ \protect\addvspace{\spaceafterchapterToC} \protect #1}
			  }
                          \fi
                          %\addcontentsline{toc}{mistix}{\protect\parbox{\protect\textwidth}{\protect\centering #1}}
                          %\addtocontents{toc}{\protect\parbox{\protect\textwidth}{\protect\centering #1}}
			\fi
                          %
                    \else
                      \relax
                    \fi
                    \chaptermark{#1}%
                    %LoT ve LoF da bölümler arası geçişde bir boşluk bırakılacaksa...
                    %\addtocontents{lof}{\protect\addvspace{10\p@}}%
                    %\addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
		\fi
                    }

\def\@makechapterhead#1{
    \thispagestyle{empty}%
    \vspace*{\ChapterUstenBosluk}%
    {\parindent \z@ \raggedright
    \normalfont
    \ifnum \c@secnumdepth >\m@ne
	\if@AppendixVar
        \th@HdFnt\th@ScSz \centering \thechapter%\space 
	\else
        \th@HdFnt\th@ScSz \thechapter. \@chapapp %\space 
	\fi
        \par\nobreak
        \vskip 10\p@
    \fi
    \interlinepenalty\@M
    \th@HdFnt\th@ScSz #1\par\nobreak
    \vskip 20\p@
  }}
\def\@schapter#1{
    \@makeschapterhead{#1}
    \@afterheading
    }
    
\def\@makeschapterhead#1{%
  \vspace*{\ChapterUstenBosluk}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \th@HdFnt\th@ScSz #1\par\nobreak
    \vskip 20\p@}}
  


\newcommand{\th@girispage}{
    \clearpage
    \thispagestyle{empty}
    \renewcommand\thefigure{G.\arabic{figure}}
    \addtocontents{toc}{\protect\addvspace{10mm}%
        \protect\vspace{2em}% 
        }   
    \addcontentsline{toc}{fhmkyl}{ \protect\bf\girisnameToC}%
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
       \vspace*{35mm}
        \th@ChapterStyle  \girisnameToC\\
    \end{list}
    \vspace*{-5mm}
    \sloppy
     \th@girisStash   % the actual GIRIS
    \newpage\clearpage
    %\captionsetup{figurewithin=chapter}
    \renewcommand\thefigure{\arabic{chapter}.\arabic{figure}}
}


\newcommand*{\th@DisKapak}{
    \thispagestyle{empty}
    \clearpage
    \vspace*{-14mm}
    \thispagestyle{empty}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
        \centering\item[]
        \th@titleFtSz {T.C. \\ ERCİYES ÜNİVERSİTESİ \\ MÜHENDİSLİK FAKÜLTESİ }
        \vfill
	\th@titleFtSz \th@title \\
        \vfill
        \th@titleFtSz Hazırlayan \\
        \th@titleFtSz \th@isimsoyisim \\ 
        \vfill
        \th@titleFtSz Danışman \\
        \th@titleFtSz \th@TeziYoneten \\
        \vfill
        %\th@titleAnaBilimDaliFtSz \th@AnaBilimDali \ Anabilim Dalı\\
        \th@titleAnaBilimDaliFtSz Bilgisayar Mühendisliği \\ Bitirme Ödevi \\
        \vfill
        \th@titleFtSz \th@date \\
        \th@titleFtSz KAYSERİ \\
    \end{list}}


\newcommand*{\th@IcKapak}{
    %\clearpage
    \vspace*{-14mm}
    \thispagestyle{empty}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    	\centering\item[]
    	\th@titleFtSz {T.C. \vspace*{1mm}\\ ERCİYES ÜNİVERSİTESİ \vspace*{1mm}\\ MÜHENDİSLİK FAKÜLTESİ }
    	\vfill
    	\th@titleFtSz \th@title \\
    	\vfill
    	\th@titleFtSz Hazırlayan \\ 
    	\vspace*{5mm}
    	\th@titleFtSz \th@isimsoyisim \\	
    	\th@titleFtSz \th@numaraBir \\
    	
		\if@AuthorIkiVar
		\th@titleFtSz \th@isimsoyisimIki \\ \th@titleFtSz \th@numaraIki \vspace*{1mm}\\  \fi
		
		
		\if@AuthorUcVar
		\th@titleFtSz \th@isimsoyisimUc \\ \th@titleFtSz \th@numaraUc \vspace*{1mm}\\ \fi
		
		
		\if@AuthorDortVar
		\th@titleFtSz \th@isimsoyisimDort \\ \th@titleFtSz \th@numaraDort \vspace*{1mm}\\ \fi
    	
    	
    	\vfill
    	\th@titleFtSz Danışman \vspace*{1mm}\\
    	\th@titleFtSz \th@TeziYoneten \\
    	\vfill
    	%\th@titleAnaBilimDaliFtSz \th@AnaBilimDali \ Anabilim Dalı\\
    	\th@titleAnaBilimDaliFtSz Bilgisayar Mühendisliği \\ Bitirme Ödevi \\
    	\vfill
    	\th@titleFtSz \th@date \vspace*{1mm}\\
    	\th@titleFtSz KAYSERİ \\
\end{list}}
  
\newcommand{\th@onaypage}{
    \clearpage
    %\vspace*{3mm}
%    \thispagestyle{empty} %% Eğer comment edilirse Sayfa numarası gözüküyor.
    \begin{minipage}[t]{\textwidth}
    \oneandonehalf
     \textbf{\textquotedblleft\th@titleCase\textquotedblright} adlı bu çalışma, jürimiz tarafından Erciyes Üniversitesi Bilgisayar Mühendisliği Bölümünde Bitirme Ödevi olarak kabul edilmiştir. \end{minipage}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
        \vspace*{10mm}
        \raggedleft{\if@OnayDateVar \th@OnayDate \else .... / .... / ....... \fi} \\
        \vfill
%        \vspace*{10mm}
        \raggedright{
        \begin{tabular}{@{}lll}
        \multicolumn{3}{@{}l}{\textbf{JÜRİ :}} \\ [12pt]
        Danışman & \multicolumn{1}{c}{:} & \if@JuriVar \th@TeziYoneten \else ................................... \fi\\ 
        & & \\
        Üye & \multicolumn{1}{c}{:} & \if@JuriVar \th@juribir \else ................................... \fi\\ 
        & & \\
        Üye & \multicolumn{1}{c}{:} & \if@JuriVar \th@juriiki \else ................................... \fi\\ 
        \end{tabular}} \\
        \vfill
        ONAY : \\
        \vspace*{10mm}
        Yukarıdaki imzaların, adı geçen öğretim elemanlarına ait olduğunu onaylarım.\\
        \vspace*{10mm}
        \vfill
        \raggedleft{
	  \newlength{\widthofmudur}
	  \settowidth{\widthofmudur}{\textbf{\th@ABDBaskani}}
	  \parbox{\widthofmudur}{\centering
          \textbf{.... / .... /20...} \\	  
          \textbf{\th@ABDBaskani} \\
          \textbf{Bilgisayar Müh. Bölüm Başkanı} \\ 
	  } 
        }
        \vspace*{10mm}
    \end{list}
    \addcontentsline{toc}{mistix}{\protect\onaynameToC}%
}

\newcommand{\th@uygunlukpage}{
    \clearpage
    \vspace*{3mm}
    \thispagestyle{empty} %% Eğer comment edilirse Sayfa numarası gözüküyor.
    \begin{minipage}[t]{\textwidth}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
    \th@ChapterStyle BİLİMSEL ETİĞE UYGUNLUK \\
    \vspace*{1cm}
    \end{list}
    \oneandonehalf
    Bu çalışmadaki tüm bilgilerin, akademik ve etik kurallara uygun bir şekilde elde edildiğini beyan ederim. Aynı zamanda bu kural ve davranışların gerektirdiği gibi, bu çalışmanın özünde olmayan tüm materyal ve sonuçları tam olarak aktardığımı ve referans gösterdiğimi belirtirim.
    \end{minipage}
    \vspace{1cm}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \item[]
    \th@isimsoyisim \\
    İmza: \\
    \end{list}
    \addcontentsline{toc}{mistix}{\protect\uygunluknameToC}%
}

\newcommand{\th@yonergeyeuygunlukpage}{
    \clearpage
     \vspace*{3mm}
     \thispagestyle{empty} %% Eğer comment edilirse Sayfa numarası gözüküyor.
    \begin{minipage}[t]{\textwidth}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
    \th@ChapterStyle YÖNERGEYE UYGUNLUK \\
    \vspace*{1cm}
    \end{list}
    	
	\oneandonehalf
    \textbf{\textquotedblleft\th@titleCase\textquotedblright}  adlı
    \if@itsaPhD
    Doktora
    \else
    Yüksek Lisans
    \fi tezi, Erciyes Üniversitesi Lisansüstü Tez Önerisi ve Tez Yazma Yönergesi’ne uygun olarak hazırlanmıştır.
    \end{minipage}
    \vspace{15mm}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
    \begin{tabular*}{\textwidth}{cc@{\extracolsep{\fill}}c}
    Tezi Hazırlayan & & Danışman \\
    \th@isimsoyisim & & \th@TeziYoneten \\
    \end{tabular*} \\
    \vspace{13cm}
    \begin{tabular}{c}
    \th@AnaBilimDali\ ABD Başkanı \\
    \th@ABDBaskani \\
    \end{tabular}
    \end{list}
    \addcontentsline{toc}{mistix}{\protect\yonergeyeToC}%
}


\newcommand{\th@Abstractpage}{
  \newpage
    \clearpage
%    \thispagestyle{empty}
    \addcontentsline{toc}{mistix}{\protect\abstractnameToC}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
      \vfill
        \th@ChapterStyle \th@titleenglish\\
        \vspace*{5mm}
        \textbf \makebox{\th@isimsoyisim}\\
        \vspace*{2pt}
        
        \textbf \makebox{Erciyes University, Computer Engineering} \\
        \vspace*{2pt}
        \textbf \makebox{Supervisor: \th@TeziYonetenenglish} \\
        \vspace*{5mm}
        \th@ChapterStyle ABSTRACT\\
    \end{list}
    \vspace*{-5mm}
    \sloppy
    \th@abstractStash   % the actual abstract
}

\newcommand{\th@ozetpage}{
  \newpage
    \clearpage
%    \thispagestyle{empty}
    \addcontentsline{toc}{mistix}{\protect\ozetnameToC}
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
        \vfill
        \th@ChapterStyle \th@title\\
        \vspace*{5mm}
        \textbf \makebox{\th@isimsoyisim}\\
        \vspace*{2pt}
        \textbf \makebox{Erciyes Üniversitesi, Bilgisayar Mühendisliği} \\
        \vspace*{2pt}
        \textbf \makebox{Danışman : \th@TeziYoneten} \\
        \vspace*{5mm}
        \th@ChapterStyle ÖZET\\
    \end{list}
    \vspace*{-7mm}
    \sloppy
    \th@ozetStash   % the actual ozet
}

\newcommand{\th@ozgecmispage}{
    \clearpage
%    \thispagestyle{empty}
    \addcontentsline{toc}{fhmkyl}{\protect\bf\ozgecmisnameToC}%
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
%       \vspace*{70mm}
        \th@ChapterStyle ÖZGEÇMİŞ\\
    \end{list}
    \vspace*{-5mm}
    \sloppy
    \th@ozgecmisStash   % the actual ozgecmis
}


\newcommand{\th@tesekkurpage}{
    \clearpage
%    \thispagestyle{empty}
    \addcontentsline{toc}{mistix}{\protect\tesekkurnameToC}%
    \begin{list}{}{\setlength{\leftmargin}{0cm}\setlength{\rightmargin}{0cm}}
    \centering\item[]
%       \vspace*{70mm}
        \th@ChapterStyle ÖNSÖZ / TEŞEKKÜR\\
    \end{list}
    \vspace*{-5mm}
    \sloppy
    \th@tesekkurStash   % the actual tesekkur
}


\renewcommand\tableofcontents{
    \setlength{\ChapterUstenBosluk}{-5mm}
    
    \chapter*{\centering\fontfamily{cmr}\normalsize\selectfont İÇİNDEKİLER\normalfont\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
    \pagestyle{empty}
    \addcontentsline{toc}{mistix}{\protect\contentsnameToC}
   \begin{center}
    \vspace*{-5mm}
    \th@HdFnt \th@title \\
    \vspace*{-5mm}
    %\vspace*{5mm}
    \end{center}
    \fontfamily{cmr}\normalfont\normalsize\
    \setlength{\ChapterUstenBosluk}{30mm}
    \newlength{\th@oldparskip}
    \setlength{\th@oldparskip}{\parskip}
    \setlength{\parskip}{\ToCparskip}
    \@starttoc{toc}
    \setlength{\parskip}{\th@oldparskip}
    
    }
  
\newcommand\symbollist{
    \setlength{\ChapterUstenBosluk}{-5mm}
    \chapter*{\symbolname\@mkboth{\MakeUppercase\symbolname}{\MakeUppercase\symbolname}}
    \setlength{\ChapterUstenBosluk}{30mm}
    \addcontentsline{toc}{mistix}{\protect\symbolnameToC}
    \th@symbollistStash}

\newcommand\abbreviation{
    \setlength{\ChapterUstenBosluk}{-5mm}
    \chapter*{\abbreviationname\@mkboth{\MakeUppercase\abbreviationname}{\MakeUppercase\abbreviationname}}
    \setlength{\ChapterUstenBosluk}{30mm}
    \addcontentsline{toc}{mistix}{\protect\abbreviationnameToC}
    \th@KisaltmalarStash}

\renewcommand\listoftables{
    \setlength{\ChapterUstenBosluk}{-5mm}
    \chapter*{\listtablename}
    \setlength{\ChapterUstenBosluk}{30mm}
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}
    \let\orig@numberline\numberline
    \renewcommand*{\numberline}[1]{%
    \orig@numberline{\tablename\ ##1.}}%
    \addcontentsline{toc}{mistix}{\protect\listtablenameToC}
    \setlength{\th@oldparskip}{\parskip}
    \setlength{\parskip}{\LoTparskip}
    \@starttoc{lot}
    \setlength{\parskip}{\th@oldparskip}
    \let\numberline\orig@numberline
    }
    
\renewcommand\listoffigures{
    \setlength{\ChapterUstenBosluk}{-5mm}
    \chapter*{\listfigurename}
    \setlength{\ChapterUstenBosluk}{30mm}
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}
    \let\orig@numberline\numberline
    \renewcommand*{\numberline}[1]{%
    \orig@numberline{\figurename\ ##1.}}%
    \addcontentsline{toc}{mistix}{\protect\listfigurenameToC}
    \setlength{\th@oldparskip}{\parskip}
    \setlength{\parskip}{\LoFparskip}
    \@starttoc{lof}
    \setlength{\parskip}{\th@oldparskip}
    \let\numberline\orig@numberline
    }
    
%\let\ORIG@listoffigures\listoffigures
%\renewcommand*{\listoffigures}{%
%\begingroup
%\let\ORIG@numberline\numberline
%\renewcommand*{\numberline}[1]{%
%% more place for the figure number is needed.
%\addtolength{\@tempdima}{\widthof{Şekillllll}}%
%\ORIG@numberline{Şekillllll ##1.}}%
%\ORIG@listoffigures
%\endgroup}

\renewcommand{\@biblabel}[1]{#1.}

\renewenvironment{thebibliography}[1]
     {
     \setlength{\ChapterUstenBosluk}{-5mm}
    \chapter*{\fontfamily{cmr}\normalsize\selectfont KAYNAKLAR\normalfont\@mkboth{\MakeUppercase\     
    contentsname}{\MakeUppercase\contentsname}}
% chapter*{\bibname}%
     \setlength{\ChapterUstenBosluk}{30mm}
     \addcontentsline{toc}{fhmkyl}{\protect\bf\bibnameToC}
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
	    \advance\leftmargin by 1.5em
	    \setlength\itemindent{-1.5em}
%   	    
            %\setlength{\leftmargin}{-\leftmargin}
            %\advance\leftmargin by 2em
%           \setlength{\itemsep}{-0.4em}%
%           \setlength{\itemindent}{0mm}%
%           \setlength{\listparindent}{0mm}%
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m
	 }
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\newcommand{\th@MakeThesisPrologue}{
        \fontfamily{cmr}
        \selectfont
        %\th@DisKapak
        \th@IcKapak
        \normalfont
        \pagenumbering{roman}%
        \setcounter{page}{0}
        %\th@uygunlukpage
	%\th@yonergeyeuygunlukpage
        \th@onaypage
        \if@TesekkurVar
        \th@tesekkurpage
        \fi
        \th@ozetpage
        \th@Abstractpage
        \ToCspacing
        \tableofcontents
	\clearpage
	\pagestyle{fancy}
        \if@TabloListesiVar
        \LoTspacing
        \listoftables
        \fi
        \if@SekilListesiVar
        \LoFspacing
        \listoffigures
        \fi
        \if@SembolListesiVar
        \symbollist
        \fi
        \if@KisaltmalarVar
        \abbreviation
        \fi
        \newpage
	\pagenumbering{arabic}
        \oneandonehalf
	\th@girispage
        \oneandonehalf
        }

\let\th@OldBeginDocument\document
\renewcommand*{\document}{
    \th@OldBeginDocument
    \th@MakeThesisPrologue
}
\endinput
