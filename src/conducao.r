dados <- local({
     con <- textConnection(
       "\"dia\"	\"aula\"
\"2023-11-14\"	\"0\"
\"2023-12-12\"	\"2\"
\"2023-12-13\"	\"1\"
\"2023-12-14\"	\"1\"
\"2023-12-15\"	\"2\"
\"2023-12-18\"	\"2\"
\"2023-12-20\"	\"2\"
\"2023-12-21\"	\"1\"
\"2023-12-22\"	\"1\"
\"2024-01-04\"	\"2\"
\"2024-01-09\"	\"2\"
\"2024-03-04\"	\"2\"
\"2024-03-05\"	\"1\"
\"2024-03-07\"	\"1\"
\"2024-03-15\"	\"2\"
\"2024-04-08\"	\"1\"
\"2024-04-10\"	\"1\"
\"2024-04-12\"	\"2\"
\"2024-04-23\"	\"2\"
\"2024-05-02\"	\"2\"
\"2024-05-03\"	\"2\""
     )
     res <- utils::read.table(
       con,
       header    = TRUE,
       row.names = NULL,
       sep       = "\t",
       as.is     = TRUE
     )
     close(con)
     res
   })
filename <- "data/conducao.csv"
limite <- 32
if (!exists("dados")) {
  dados <- read.csv(filename)
}
dados <- transform(dados, Ni=cumsum(dados$aula))
plot(
  dados$Ni,x=as.Date(dados$dia),
  xaxs="i", yaxs="i",
  type="S", ylim=c(0, limite + 1),
  xlab="dia", ylab="aula", main="Aulas de Condução"
)
grid(nx = as.numeric(difftime(max(dados$dia), min(dados$dia), unit = "days")) + 1, lty=1, lwd=1)
abline(h=limite, col="blue")
