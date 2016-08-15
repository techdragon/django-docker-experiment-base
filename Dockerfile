FROM debian:jessie

ADD ./version /version

RUN \
apt-get update && apt-get install -y --no-install-recommends \
wget \
curl \
ca-certificates \
&& \
"deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
&& \
wget --quiet -O postgresql.key https://www.postgresql.org/media/keys/ACCC4CF8.as \
&& \
apt-key add postgresql.key \
&& \
rm postgresql.key
&& \
apt-get update && apt-get install -y --no-install-recommends \
git-core \
build-essential \
libssl-dev \
libreadline-dev \
libbz2-dev \
libsqlite3-dev \
libffi-dev \
llvm \
zlib1g-dev \
libncurses5-dev \
make \
postgresql-9.5-postgis-2.2 \
pgadmin3 \
postgresql-contrib-9.5 \
spatialite-bin \
libsqlite3-mod-spatialite \
&& \
apt-get clean \
&& \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone git://github.com/yyuu/pyenv.git && \
cd pyenv/plugins/python-build && \
    ./install.sh
