df <- read.csv(file.path("data", "aulas.csv"))

dias <- as.Date(df$dia)
codigo <- cumsum(df$codigo)
conducao <- cumsum(df$conducao)

tabela <- data.frame(
  categorias = c("Código", "Condução"),
  progresso = c(
    max(codigo[dias <= Sys.Date()]),
    max(conducao[dias <= Sys.Date()])
  ),
  alvo = c(28, 32)
)

tabela <- transform(
  tabela,
  relativo = sprintf("%0.1f%%", tabela$progresso / tabela$alvo * 100),
  completo = c(FALSE, FALSE)
)

print(tabela)
print(
  sprintf(
    "Média de progresso: %0.1f%%",
    mean(tabela$progresso / tabela$alvo * 100)
  )
)
