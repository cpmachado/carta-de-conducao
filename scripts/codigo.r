df <- read.csv(file.path("data", "aulas.csv"))

dias <- c(
  as.Date("2023-11-14"),
  as.Date(df$dia[df$codigo > 0]),
  as.Date(Sys.Date()) + 30
)
codigo <- cumsum(c(0, df$codigo[df$codigo > 0], 0))

min_dias <- min(dias)
max_dias <- max(dias)
max_codigo <- max(codigo)
diff_dias <- as.numeric(difftime(max_dias, min_dias, unit = "days"))


png(file.path("res", "codigo.png"),
  width = 8, height = 8, units = "cm",
  res = 2048, pointsize = 4
)

plot(
  dias, codigo,
  ylim = c(0, 30), xaxs = "i", yaxs = "i",
  xlab = "dia", ylab = "N", main = "Aulas de Código"
)

grid(nx = diff_dias, ny = 15, lty = 1, col = "gray", lwd = 1)

# Linhas do código
a <- min_dias
x <- dias[codigo < 8]
b <- max(x)
y <- codigo[codigo < 8]
polygon(
  x = c(a, x, b),
  y = c(0, y, 0),
  col = adjustcolor("green", alpha.f = 0.5)
)
if (max_codigo >= 7) {
  a <- b
  x <- dias[codigo > 7 & codigo < 24]
  b <- max(x)
  y <- codigo[codigo > 7 & codigo < 24]
  polygon(
    x = c(a, a, x, b),
    y = c(0, 7, y, 0),
    col = adjustcolor("yellow3", alpha.f = 0.5)
  )
  if (max_codigo > 23) {
    a <- b
    x <- dias[codigo > 23]
    b <- max(x)
    y <- codigo[codigo > 23]
    polygon(
      x = c(a, a, x, b),
      y = c(0, 23, y, 0),
      col = adjustcolor("red", alpha.f = 0.5)
    )
  }
}


# linhas guia
abline(h = 7, col = "green", lty = 2)
abline(h = 23, col = "yellow3", lty = 2)
abline(h = 28, col = "red", lty = 2)

abline(v = as.Date(Sys.Date()), col = "black")
abline(v = as.Date("2023-11-27"), col = "black", lty = 4)
abline(v = as.Date("2023-12-27"), col = "black", lty = 4)
abline(v = as.Date("2024-01-27"), col = "black", lty = 4)

legend(
  x = "left",
  legend = c("Código Verdes", "Código Amarelas", "Código Vermelhas", "Actual"),
  col = c("green", "yellow3", "red", "black"),
  lty = 1,
  lwd = 1
)
