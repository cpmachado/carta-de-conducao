df <- read.csv(file.path("data", "aulas.csv"))

dias <- as.Date(df$dia)
codigo_verdes <- cumsum(df$codigo_verdes)
codigo_amarelas <- codigo_verdes + cumsum(df$codigo_amarelas)
codigo <- codigo_amarelas + cumsum(df$codigo_vermelhas)
simulador <- cumsum(df$simulador)
conducao <- simulador + cumsum(df$conducao)

diff_dias <- as.numeric(difftime(max(dias), min(dias), unit = "days"))


png("progresso.png",
  width = 8,
  height = 8,
  units = "cm",
  res = 2048,
  pointsize = 4
)
plot(dias, codigo,
  type = "l", ylim = c(0, 40), xaxs = "i", yaxs = "i",
  xlab = "dia", ylab = "Nro aulas de Código", lty = 1,
  col = "red"
)
grid(
  nx = diff_dias, ny = 20,
  lty = 1,
  col = "gray",
  lwd = 1
)
lines(dias, codigo_amarelas, col = "yellow")
lines(dias, codigo_verdes, col = "green")
lines(dias, conducao, col = "blue")
lines(dias, simulador, col = "orange")
legend(
  x = "topright",
  legend = c(
    "Código Verdes(1-7, presenciais)",
    "Código Amarelas(8-23, online)",
    "Código Vermelhas(24-28, presenciais)",
    "Simulador(Primeiras 8)",
    "Condução"
  ),
  col = c("green", "yellow", "red", "orange", "blue"),
  lty = 1,
  lwd = 1
)
abline(h = 32, col = "blue", lty = 2)
abline(h = 28, col = "red", lty = 2)
abline(h = 23, col = "yellow", lty = 2)
abline(h = 8, col = "orange", lty = 2)
abline(h = 7, col = "green", lty = 2)
