#! /bin/bash -e

apt-get update
apt-get install -y --no-install-recommends $@
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
