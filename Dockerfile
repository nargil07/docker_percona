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

EXPOSE 3306

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

RUN chmod 777 -R /var/lib/mysql

CMD ["mysqld"]
