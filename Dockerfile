# Etapa 1: Construção do binário
FROM golang:alpine AS builder

# Instalar git
RUN apk update && apk add --no-cache git

# Configurar diretório de trabalho
WORKDIR /app

# Adicionar o código fonte
COPY . .

# Construir o binário
RUN go mod init olamundo
RUN go build -o /go/bin/olamundo

# Etapa 2: Criar imagem mínima
FROM scratch

# Copiar o binário construído para a nova imagem
COPY --from=builder /go/bin/olamundo /go/bin/olamundo

# Definir o ponto de entrada
ENTRYPOINT ["/go/bin/olamundo"]
