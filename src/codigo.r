dados <- local({
     con <- textConnection(
       "\"dia\"	\"aula\"
\"2023-11-14\"	\"0\"
\"2023-11-28\"	\"2\"
\"2023-11-29\"	\"1\"
\"2023-11-30\"	\"1\"
\"2023-12-04\"	\"1\"
\"2023-12-05\"	\"1\"
\"2023-12-06\"	\"1\"
\"2023-12-07\"	\"4\"
\"2023-12-09\"	\"1\"
\"2023-12-10\"	\"1\"
\"2023-12-16\"	\"1\"
\"2023-12-17\"	\"2\"
\"2023-12-18\"	\"4\"
\"2023-12-19\"	\"1\"
\"2024-01-09\"	\"1\"
\"2024-01-11\"	\"1\"
\"2024-01-15\"	\"1\"
\"2024-01-16\"	\"1\"
\"2024-01-17\"	\"1\"
\"2024-01-18\"	\"1\"
\"2024-01-19\"	\"1\"
\"2024-01-20\"	\"0\""
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
filename <- "data/codigo.csv"
limite <- 28
if (!exists("dados")) {
  dados <- read.csv(filename)
}
dados <- transform(dados, Ni=cumsum(dados$aula))
plot(
  dados$Ni,x=as.Date(dados$dia),
  xaxs="i", yaxs="i",
  type="S", ylim=c(0, limite + 1),
  xlab="dia", ylab="aula", main="Aulas de Código"
)
grid(nx = as.numeric(difftime(max(dados$dia), min(dados$dia), unit = "days")) + 1, lty=1, lwd=1)
abline(h=limite, col="blue")
