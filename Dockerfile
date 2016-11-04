FROM debian:stable
MAINTAINER Caner Dagli<cdagli@eriktronik.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get -y update
RUN apt-get -y install ca-certificates rpl pwgen

RUN apt-get install -y postgresql-9.5-postgis-2.2 netcat
ADD config/postgres-supervisor.conf /etc/supervisor/conf.d/postgres.conf

# Open port 5432 so linked containers can see them
EXPOSE 5432

# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.
ADD config/setup.sh /setup.sh
RUN chmod 0755 /setup.sh
#RUN /setup.sh

# We will run any commands in this when the container starts
ADD config/start-postgis.sh /start-postgis.sh
RUN chmod 0755 /start-postgis.sh

COPY config/init_db.sh /

CMD /setup.sh && /start-postgis.sh