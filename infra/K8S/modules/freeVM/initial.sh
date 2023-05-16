#!/bin/bash
# redirect stdout/stderr to a file
exec > /tmp/start-up.log 2>&1

# start timestamp
date
echo "this is start up script"

apt install -y net-tools htop vim ca-certificates curl gnupg tmux zsh
