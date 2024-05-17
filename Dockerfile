FROM golang:1.22 AS builder
WORKDIR /go/src/github.com/fxcl/co2api
COPY main.go ./
COPY go.mod ./
COPY go.sum ./
COPY types.go ./
COPY utils.go ./
RUN go get -d -v ./
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o co2api .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /go/src/github.com/fxcl/co2api/co2api /app/co2api
CMD ["/app/co2api"]
