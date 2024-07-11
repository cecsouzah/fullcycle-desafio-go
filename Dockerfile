# Etapa 1: Construção do binário
FROM golang:1.22.5-alpine3.20 AS builder

# Instalar git
RUN apk update && apk add --no-cache git

# Configurar diretório de trabalho
WORKDIR /app

# Adicionar o código fonte
COPY . .

# Construir o binário
RUN go mod init fullcycle
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /go/bin/fullcycle

# Etapa 2: Criar imagem mínima
FROM scratch

# Copiar o binário construído para a nova imagem
COPY --from=builder /go/bin/fullcycle /go/bin/fullcycle

# Definir o ponto de entrada
ENTRYPOINT ["/go/bin/fullcycle"]
