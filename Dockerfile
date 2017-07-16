FROM quay.io/vektorcloud/go:dep AS build

ENV VERSION v0.6.0

RUN go get github.com/mesosphere/mesos-dns \
  && cd /go/src/github.com/mesosphere/mesos-dns \
  && git checkout $VERSION \
  && go build -o /tmp/mesos-dns

FROM quay.io/vektorcloud/base:3.6

COPY --from=build /tmp/mesos-dns /bin/mesos-dns

ENTRYPOINT ["/bin/mesos-dns"]
