#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y libsqlite3-0 libsqlite3-dev build-essential jq wget curl binutils git ninja-build libgtk-3-dev
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq