# Makefile
# Makefile used for NUT Configuration Examples
# Copyright (C) 2017-2021 Roger Price

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, 
# Boston, MA  02111-1307, USA.

# How many times does LaTeX have to be run?  The answer is: as many
# times as are necessary to get a run with no message
#
#   LaTeX Warning: Label(s) may have changed.
#   Rerun to get cross-references right.
#
# followed by another call of makeindex with the correct index
# entries, followed by a final run of LaTeX to incorporate this index
# into the document.  In other words, if the first three runs have the
# warning "Label(s) may have changed", you need five runs of LaTeX
# intermixed with four runs of makeindex.

# If you are really serious, an extra run to feed the page numbers due
# to the new index into the table of contents would be advisable, but
# wouldn't that possibly push the whole document back another page?
# Perhaps another run of LaTeX...

# Where does this stuff get installed?
SERVER = /srv/www/htdocs
DIR = NUT

FIGURES = bad.fig bad.pdf\
          big.fig big.pdf\
          delayedUPSshutdown.fig delayedUPSshutdown.pdf\
          dual.fig dual.pdf\
          heartbeat.fig heartbeat.pdf\
          intro.fig intro.pdf\
          overview-OB.fig overview-OB.pdf\
          overview-OL.fig overview-OL.pdf\
          server.fig server.pdf\
          shutdownrace.fig shutdownrace.pdf\
          slave.fig slave.pdf\
          workstation.fig workstation.pdf\
          Danger.png UPS-1.jpg UPS-2.jpg UPS-3.jpg UPS-4.jpg

####### The Guide in a landscape 19 inch monitor PDF file #######
ConfigExamples.pdf: ConfigExamples.tex A5.1col.tex Makefile $(FIGURES)
	rm -f ConfigExamples.pdf ConfigExamples.idx ConfigExamples.aux
	echo "%%%%%%%%%%%%%%%%%% First pass %%%%%%%%%%%%%%%%%%%%%"
	pdflatex "\newcommand{\ncols}{one}\input{ConfigExamples.tex}"
	echo "%%%%%%%%%%%%%%%%%% Second pass %%%%%%%%%%%%%%%%%%%%%"
	pdflatex "\newcommand{\ncols}{one}\input{ConfigExamples.tex}"
	echo "%%%%%%%%%%%%%%%%%% Third pass %%%%%%%%%%%%%%%%%%%%%"
	pdflatex "\newcommand{\ncols}{one}\input{ConfigExamples.tex}"
#	echo "%%%%%%%%%%%%%%%%%% Fourth pass %%%%%%%%%%%%%%%%%%%%%"
#	pdflatex "\newcommand{\ncols}{one}\input{ConfigExamples.tex}"
	cp ConfigExamples.pdf ConfigExamples.A5.pdf

# Clean out temporary files
clean: Makefile $(FIGURES)
	rm -f ConfigExamples.log ConfigExamples.aux ConfigExamples.toc\
              ConfigExamples.lof ConfigExamples.lot ConfigExamples.bbl\
              ConfigExamples.blg ConfigExamples.idx ConfigExamples.ilg\
              ConfigExamples.ind ConfigExamples.dvi ConfigExamples.pdf\
              temp.ps ConfigExamples.pdf\
              ConfigExamples.A4.pdf ConfigExamples.A5.pdf

# RP The install option is for my personal use 
# Place the Guide and the tarball on olive's web site
# Note: This augments the work of the Makefile in ~/public_html/NUT/
install: ConfigExamples.pdf Makefile $(FIGURES)
	(cd $(SERVER) && mkdir -p $(DIR) )
	rm -rf                      $(SERVER)/$(DIR)/CongigExamples.A5.pdf
	cp ConfigExamples.A5.pdf    $(SERVER)/$(DIR)/ConfigExamples.A5.pdf
