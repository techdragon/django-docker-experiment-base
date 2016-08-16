FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN \
echo "#! /bin/sh" > /usr/bin/clean-install && \
echo "" >> /usr/bin/clean-install && \
echo "apt-get update" >> /usr/bin/clean-install && \
echo "apt-get install -y --no-install-recommends $@" >> /usr/bin/clean-install && \
echo "apt-get clean" >> /usr/bin/clean-install && \
echo "rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*" >> /usr/bin/clean-install && \
chmod +x /usr/bin/clean-install

# #####
# NOTES
# #####
# INSTALL COMMANDS
# apt-get update && apt-get install -y --no-install-recommends $PACKAGES_TO_ADD
# CLEANUP COMMANDS
# apt-get remove --purge -y $PACKAGES_TO_REMOVE $(apt-mark showauto) && rm -rf /var/lib/apt/lists/*

RUN clean-install wget curl ca-certificates
RUN \
echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
wget -O postgresql.key https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
apt-key add postgresql.key && \
rm postgresql.key

RUN clean-install \
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
make

RUN clean-install postgresql-9.5-postgis-2.2

RUN clean-install postgresql-contrib-9.5

RUN clean-install spatialite-bin

# RUN apt-rdepends -rp --state-follow=Installed --state-show=Installed python
# RUN apt-rdepends -rp --state-follow=Installed --state-show=Installed python-minimal
# RUN apt-cache rdepends python
# RUN apt-cache rdepends python-minimal
# RUN apt-get uninstall -y python
# RUN apt-get uninstall -y python-minimal

RUN git clone git://github.com/yyuu/pyenv.git && \
cd pyenv/plugins/python-build && \
    ./install.sh
