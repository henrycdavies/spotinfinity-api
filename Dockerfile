# builder image
FROM golang:1.19.2-alpine3.16 as builder
RUN mkdir /build
ADD * /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -o spotinfinity-api .


# generate clean, final image for end users
FROM alpine:3.16
COPY --from=builder /build/spotinfinity-api .

# executable
ENTRYPOINT [ "./spotinfinity-api" ]
# arguments that can be overridden
CMD [ "3", "300" ]