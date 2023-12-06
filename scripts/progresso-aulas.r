df <- read.csv(file.path("data", "aulas.csv"))

dias <- as.Date(df$dia)
codigo <- cumsum(df$codigo_verdes + df$codigo_amarelas + df$codigo_vermelhas)

png("progresso.png")
plot(dias, codigo, type = "l", ylim = c(0, 29), xaxs="i")
lines(dias, codigo * 0 + 28, lty = 2)
