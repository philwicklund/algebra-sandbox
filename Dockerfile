FROM golang:1.14.6-alpine3.12 as builder
COPY go.mod go.sum /go/src/github.com/philwicklund/algebra-sandbox/
WORKDIR /go/src/github.com/philwicklund/algebra-sandbox
#RUN go mod download
COPY . /go/src/github.com/philwicklund/algebra-sandbox
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/algebra-sandbox github.com/philwicklund/algebra-sandbox

FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /go/src/github.com/philwicklund/algebra-sandbox/build/algebra-sandbox /usr/bin/algebra-sandbox
EXPOSE 10000 10000
ENTRYPOINT ["/usr/bin/algebra-sandbox"]