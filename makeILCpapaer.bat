echo off

set theFile=robotJointILC

echo ****************************************************************
echo TeXen  %theFile%-Presentation
rem echo Scheint nicht zu funktionieren - von Hand machen!!
rem echo Pfad: o:\pJoint Elektronic Software\Documentation\control\Valve\
echo ****************************************************************



pdflatex %theFile%.tex
bibtex %theFile%
pdflatex %theFile%.tex
pdflatex %theFile%.tex

rem del *.aux *.toc *.log *.blg *.snm *.out *.nav


rem pause
