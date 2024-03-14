filename <- "data/codigo.csv"
limite <- 28
if (!exists("dados")) {
  dados <- read.csv(filename)
}
dados <- transform(dados, Ni=cumsum(dados$aula))
plot(
  dados$Ni,x=as.Date(dados$dia),
  xaxs="i", yaxs="i",
  type="s", ylim=c(0, limite + 1),
  xlab="dia", ylab="aula", main="Aulas de Código"
)
grid(nx = as.numeric(difftime(max(dados$dia), min(dados$dia), unit = "days")) + 1, lty=1, lwd=1)
abline(h=28, col="blue")
