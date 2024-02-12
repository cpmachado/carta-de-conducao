df <- read.csv(file.path("data", "aulas.csv"))

dias <- c(
  as.Date("2023-11-14"),
  as.Date(df$dia[df$conducao > 0]),
  as.Date(Sys.Date()) + 50
)
conducao <- cumsum(c(0, df$conducao[df$conducao > 0], 0))

min_dias <- min(dias)
max_dias <- max(dias)
max_conducao <- max(conducao)
diff_dias <- as.numeric(difftime(max_dias, min_dias, unit = "days"))


png(file.path("res", "conducao.png"),
  width = 8,
  height = 8,
  units = "cm",
  res = 2048,
  pointsize = 4
)

plot(dias, conducao,
  ylim = c(0, 34), xaxs = "i", yaxs = "i",
  xlab = "dia", ylab = "N", main = "Aulas de Condução"
)
grid(
  nx = diff_dias,
  ny = 17,
  lty = 1,
  col = "gray",
  lwd = 1
)

# Linhas da condução
a <- min_dias
x <- dias[conducao < 9]
b <- max(x)
y <- conducao[conducao < 9]
polygon(
  x = c(a, x, b),
  y = c(0, y, 0),
  col = adjustcolor("orange", alpha.f = 0.5)
)
if (max_conducao >= 8) {
  a <- b
  x <- dias[conducao > 8 & conducao < 17]
  b <- max(x)
  y <- conducao[conducao > 8 & conducao < 17]
  polygon(
    x = c(a, a, x, b),
    y = c(0, 8, y, 0),
    col = adjustcolor("blue", alpha.f = 0.5)
  )
  if (max_conducao >= 17) {
    a <- b
    x <- dias[conducao > 16]
    b <- max(x)
    y <- conducao[conducao > 16]
    polygon(
      x = c(a, a, x, b),
      y = c(0, 16, y, 0),
      col = adjustcolor("blue4", alpha.f = 0.5)
    )
  }
}

# linhas guia
abline(h = 8, col = "orange", lty = 2)
abline(h = 16, col = "blue", lty = 2)
abline(h = 32, col = "blue4", lty = 2)

abline(v = as.Date(Sys.Date()), col = "black")
abline(v = as.Date("2023-11-27"), col = "black", lty = 4)
abline(v = as.Date("2023-12-27"), col = "black", lty = 4)
abline(v = as.Date("2024-01-27"), col = "black", lty = 4)

legend(
  x = "left",
  legend = c(
    "Simulador",
    "Condução(para exame de código)",
    "Condução",
    "Actual"
  ),
  col = c("orange", "blue", "blue4", "black"),
  lty = 1,
  lwd = 1
)
