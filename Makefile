progresso.png: scripts/progresso-aulas.r data/aulas.csv
	Rscript scripts/progresso-aulas.r
lint:
	Rscript -e 'library(lintr);lint_dir(".")'
style:
	Rscript -e 'library(styler);style_dir(".")'
.PHONY: lint style
