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
polygon(
  x = c(
    min(dias[codigo >= 7 & codigo < 24]),
    dias[codigo >= 7 & codigo < 24],
    max(dias[codigo >= 7 & codigo < 24])
  ),
  y = c(0, codigo[codigo >= 7 & codigo < 24], 0),
  col = adjustcolor("yellow3", alpha.f = 0.5)
)
polygon(
  x = c(
    min(dias[codigo <= 8]),
    dias[codigo <= 8],
    max(dias[codigo <= 8])
  ),
  y = c(0, codigo[codigo <= 8], 0),
  col = adjustcolor("green", alpha.f = 0.5)
)

# Linhas da condução
polygon(
  x = c(
    min(dias[conducao >= 8]),
    dias[conducao >= 8],
    max(dias[conducao >= 8])
  ),
  y = c(0, conducao[conducao >= 8], 0),
  col = adjustcolor("blue", alpha.f = 0.5)
)
polygon(
  x = c(
    min(dias[conducao <= 8]),
    dias[conducao <= 8],
    max(dias[conducao <= 8])
  ),
  y = c(0, conducao[conducao <= 8], 0),
  col = adjustcolor("orange", alpha.f = 0.5)
)

# linhas guia
abline(h = 7, col = "green", lty = 2)
abline(h = 23, col = "yellow3", lty = 2)
abline(h = 28, col = "red", lty = 2)
abline(h = 8, col = "orange", lty = 2)
abline(h = 32, col = "blue", lty = 2)
abline(v = as.Date(Sys.Date()), col = "black", lty = 2)
abline(h = max(codigo[dias <= as.Date(Sys.Date())]), col = "black", lty = 2)
abline(h = max(conducao[dias <= as.Date(Sys.Date())]), col = "black", lty = 2)

legend(
  x = "left",
  legend = c(
    "Código Verdes",
    "Código Amarelas",
    "Código Vermelhas",
    "Simulador",
    "Condução",
    "Actual"
  ),
  col = c("green", "yellow3", "red", "orange", "blue", "black"),
  lty = 1,
  lwd = 1
)
