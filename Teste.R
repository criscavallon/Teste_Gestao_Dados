
# importando a base
dados = read.csv("Cristiana Campos Cavallon - PlayTennis.csv", sep = ";", na.strings = "")

# Explorando a base para verificar dados ausentes e outliers
summary(dados)
dados[!complete.cases(dados),]

#buscar duplicados pelo Id
x = dados[duplicated(dados$Id),]
x
## Não há linhas duplicadas.

# Tratar NA em dados categóricos - MODA

## Coluna Vento (preencher com a moda: FALSO)
dados$Vento = ifelse(is.na(dados$Vento), 'FALSO' , dados$Vento)

### Verificar se a substituição foi feita
dados[!complete.cases(dados$Vento),]

# Tratar NA em dados numéricos - MEDIANA

## Coluna Temperatura (substituir NA por mediana)
dados[is.na(dados$Temperatura),]$Temperatura = median(dados$Temperatura, na.rm = T)

### Verificar se a substituição foi feita
summary(dados$Temperatura)
dados[!complete.cases(dados$Temperatura),]

## Coluna Umidade (substituir NA por mediana)
dados[is.na(dados$Umidade),]$Umidade = median(dados$Umidade, na.rm = T)

### Verificar se a substituição foi feita
summary(dados$Umidade)
dados[!complete.cases(dados$Umidade),]

# Tratar valores atípicos

## valor negativo em Umidade (substituir pela mediana)
dados$Umidade = ifelse(dados$Umidade < 0, median(dados$Umidade, na.rm = T), dados$Umidade)

### Verificar se a substituição foi feita
summary(dados$Umidade)

## outliers em Temperatura e Umidade (substituir pela mediana)

#calcular desvio padrão - Temperatura
desv = sd(dados$Temperatura, na.rm = T)
desv

#identificar valores outliers - Temperatura
dados[dados$Temperatura >= 2*desv ,]$Temperatura

#atualizar todos para a mediana - Temperatura
dados[dados$Temperatura >= 2*desv ,]$Temperatura = median(dados$Temperatura)

#checar se os outliers foram removidos - Temperatura
dados[dados$Temperatura >= 2*desv ,]$Temperatura
summary(dados$Temperatura)

#calcular desvio padrão - Umidade
desv = sd(dados$Umidade, na.rm = T)
desv

#identificar valores outliers - Umidade
dados[dados$Umidade >= 2*desv ,]$Umidade

#atualizar todos para a mediana - Umidade
dados[dados$Umidade >= 2*desv ,]$Umidade = median(dados$Umidade)

#checar se os outliers foram removidos - Umidade
dados[dados$Umidade >= 2*desv ,]$Umidade
summary(dados$Umidade)

#Verificar a base novamente
summary(dados)
dados[!complete.cases(dados),]
