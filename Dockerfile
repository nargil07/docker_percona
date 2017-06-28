FROM debian:wheezy

ENV PERCONA_VERSION 5.7

RUN groupadd -r mysql && useradd -r -g mysql -u 1001 -r -g 0 -s /sbin/nologin \
    -c "Default Application User" mysql

RUN apt-get update && apt-get install -y wget ca-certificates

RUN \
    wget https://repo.percona.com/apt/percona-release_0.1-4.wheezy_all.deb && \
    dpkg -i percona-release_0.1-4.wheezy_all.deb && \
    rm percona-release_0.1-4.wheezy_all.deb && \
    apt-get update && apt-get install -y percona-server-server-$PERCONA_VERSION
   
RUN \
    apt-get install -y wget && \
    wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb && \
    dpkg -i dumb-init_*.deb

EXPOSE 3306

VOLUME ["/var/lib/mysql", "/var/log/mysql"]


COPY percona-launch.sh /tmp/percona-launch.sh
RUN chmod +x /tmp/percona-launch.sh

CMD ["/tmp/percona-launch"]
