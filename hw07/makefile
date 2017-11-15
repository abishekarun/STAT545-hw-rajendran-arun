## one Makefile to make them all

all: 03_report.html

gapminder.tsv:
	Rscript 00_download_data.R

gapminder_reordered.rds: gapminder.tsv 01_exploratory_analysis.R
	Rscript 01_exploratory_analysis.R

%.jpeg: gapminder_reordered.rds 02_statistical_analysis.R
	Rscript 02_statistical_analysis.R

03_report.html: 03_report.Rmd
	Rscript -e "rmarkdown::render('03_report.Rmd')"

# Exclude directory from find . command
GARBAGE_TYPES         := *.rds *.tsv *.jpeg 
DIRECTORIES_TO_CLEAN  := $(shell find -not -path "./.git**" -not -path "./images**" -type d)
GARBAGE_TYPED_FOLDERS := $(foreach DIR, $(DIRECTORIES_TO_CLEAN), $(addprefix $(DIR)/,$(GARBAGE_TYPES)))

clean:
	$(RM) -rf $(GARBAGE_TYPED_FOLDERS)
	rm -rf $(TMP)
  # echo $(GARBAGE_TYPED_FOLDERS)