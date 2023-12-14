df <- read.csv(file.path("data", "aulas.csv"))

dias <- as.Date(df$dia)
codigo <- cumsum(df$codigo)
conducao <- cumsum(df$conducao)

diff_dias <- as.numeric(
  difftime(
    max(dias),
    min(dias),
    unit = "days"
  )
)

png("progresso.png",
  width = 8,
  height = 8,
  units = "cm",
  res = 2048,
  pointsize = 4
)

plot(
  dias,
  codigo,
  ylim = c(0, 34),
  xaxs = "i",
  yaxs = "i",
  xlab = "dia",
  ylab = "Nro de aulas",
  col = "white"
)
grid(
  nx = diff_dias,
  ny = 17,
  lty = 1,
  col = "gray",
  lwd = 1
)

# Linhas do código
lines(
  dias[codigo <= 7],
  codigo[codigo <= 7],
  col = "green",
  type = "s"
)
lines(
  dias[codigo >= 7 & codigo <= 23],
  codigo[codigo >= 7 & codigo <= 23],
  col = "yellow3",
  type = "s"
)
lines(
  dias[codigo >= 23],
  codigo[codigo >= 23],
  col = "red",
  type = "s"
)
abline(h = 7, col = "green", lty = 2)
abline(h = 23, col = "yellow3", lty = 2)
abline(h = 28, col = "red", lty = 2)

# Linhas da condução
lines(
  dias[conducao <= 8 & dias <= Sys.Date()],
  conducao[conducao <= 8 & dias <= Sys.Date()],
  col = "orange",
  type = "s"
)
lines(dias[conducao <= 8 & dias >= Sys.Date()],
  conducao[conducao <= 8 & dias >= Sys.Date()],
  col = "orange", lty = 2,
  type = "s"
)
lines(
  dias[conducao >= 8],
  conducao[conducao >= 8],
  col = "blue",
  type = "s"
)
abline(h = 8, col = "orange", lty = 2)
abline(h = 32, col = "blue", lty = 2)

legend(
  x = "left",
  legend = c(
    "Código Verdes",
    "Código Amarelas",
    "Código Vermelhas",
    "Simulador",
    "Condução"
  ),
  col = c("green", "yellow3", "red", "orange", "blue"),
  lty = 1,
  lwd = 1
)
