### Builder
FROM golang:1.13-alpine as builder
RUN apk update && apk add git

WORKDIR /usr/src/app
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -ldflags '-s' -o main .


### Make executable image
FROM scratch

COPY --from=builder /usr/src/app .
CMD [ "/main" ]

