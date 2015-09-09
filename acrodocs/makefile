## MUST "double-specify" the file suffixes in use

.SUFFIXES: .tex .pdf .Rnw

## Now set up file names with local dictionary



TARGET = IntroProb1aAxioms IntroProb1aSets IntroProb1bPermuteComb IntroProb2Conditional IntroProb2cInequalities IntroProb3DiscreteFunctions IntroProb3cDiscreteExamples IntroProb3bDiscreteMultivariate IntroProb4Continuous IntroProb5Moments IntroProb6Likelihood IntroProb7LargeSampleTheory IntroProb8IntervalEstimates IntroProbFamousDistributions KeyMath
MYTARGET = $(TARGET:=.pdf)
MYDEP = $(TARGET:=.tex)

all: $(MYTARGET)


$(MYTARGET): $(MYDEP)

.tex.pdf:
	pdflatex $*.tex
	pdflatex $*.tex
	pdflatex $*.tex

.Rnw.tex:
	R CMD Sweave $*.Rnw


clean:
	rm -fv *.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof *.qsl *.sol *.cut
	rm -fv *.vrb *.out *.nav *.snm \#*\# Rplots.pdf
	cp *.pdf ~/Dropbox/Public/introprob/






