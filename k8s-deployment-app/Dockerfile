FROM golang:1.13-alpine AS build

EXPOSE 8080
WORKDIR /src/
COPY hello.go go.* /src/

RUN CGO_ENABLED=0 go build -o /bin/hello

ENTRYPOINT ["/bin/hello"]