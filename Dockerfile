FROM quay.io/vektorcloud/base

ENV MESOS_DNS_VERSION v0.6.0
ENV GLIBC_VERSION 2.23-r3

# TODO: Consider moving these into vektorcloud/base
RUN apk update && apk add --no-cache gpgme openssl

# Installs glibc from https://github.com/sgerrand/alpine-pkg-glibc
# TODO: Move this into a seperate branch on vektorcloud/base
RUN wget -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
  wget -O "/tmp/glibc-$GLIBC_VERSION.apk" "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-$GLIBC_VERSION.apk" && \
  apk add "/tmp/glibc-$GLIBC_VERSION.apk" && \
  rm -v /tmp/glibc*

RUN cd /tmp && \
  wget "https://raw.githubusercontent.com/mesosphere/mesos-dns/master/build/public.key" && \
  wget "https://github.com/mesosphere/mesos-dns/releases/download/$MESOS_DNS_VERSION/mesos-dns-$MESOS_DNS_VERSION-linux-amd64" && \
  wget "https://github.com/mesosphere/mesos-dns/releases/download/$MESOS_DNS_VERSION/mesos-dns-$MESOS_DNS_VERSION-linux-amd64.asc" && \
  gpg --import public.key && \
  gpg --verify "mesos-dns-$MESOS_DNS_VERSION-linux-amd64.asc" "mesos-dns-$MESOS_DNS_VERSION-linux-amd64" && \
  mv -v "mesos-dns-$MESOS_DNS_VERSION-linux-amd64" "/usr/bin/mesos-dns" && \
  chmod +x /usr/bin/mesos-dns && \
  rm -v /tmp/*

CMD ["/usr/bin/mesos-dns"]
