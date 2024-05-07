#!/bin/bash

apt update
apt upgrade -y
apt install -y libsqlite3-0 libsqlite3-dev build-essential jq wget curl binutils git