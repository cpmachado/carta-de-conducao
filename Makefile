GRAFICOS =\
	res/codigo.png\
	res/conducao.png

res/%.png: scripts/%.r data/aulas.csv
	Rscript $<

all: $(GRAFICOS)
	@echo gráficos gerados

res/codigo.png: scripts/codigo.r data/aulas.csv
res/conducao.png: scripts/conducao.r data/aulas.csv

lint:
	Rscript -e 'library(lintr);lint_dir(".")'
style:
	Rscript -e 'library(styler);style_dir(".")'

.PHONY: lint style all
