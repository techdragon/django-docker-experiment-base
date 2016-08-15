FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN \
apt-get update && apt-get install -y --no-install-recommends \
wget \
curl \
ca-certificates \
&& \
echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
&& \
wget -O postgresql.key https://www.postgresql.org/media/keys/ACCC4CF8.asc \
&& \
apt-key add postgresql.key \
&& \
rm postgresql.key \
&& \
apt-get update && apt-get install -y --no-install-recommends \
git-core \
build-essential  \
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
postgresql-contrib-9.5 \
spatialite-bin \
&& \
apt-get clean \
&& \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-rdepends -rp --state-follow=Installed --state-show=Installed python
RUN apt-rdepends -rp --state-follow=Installed --state-show=Installed python-minimal
# RUN apt-cache rdepends python
# RUN apt-cache rdepends python-minimal

RUN git clone git://github.com/yyuu/pyenv.git && \
cd pyenv/plugins/python-build && \
    ./install.sh
