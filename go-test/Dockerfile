FROM golang:alpine3.11
RUN apk add git --update && go get  -v github.com/gin-gonic/gin && go get -u github.com/json-iterator/go
WORKDIR /root
COPY . .
RUN go build -tags=jsoniter . 

FROM alpine
ENV PATH /root:/go/bin:/bin:/sbin
WORKDIR /root
COPY --from=0  /root/root .
EXPOSE 8080
ENTRYPOINT ["root"]
