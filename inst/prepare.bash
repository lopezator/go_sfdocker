#!/usr/bin/env bash

prepare_inst() {
    case $1 in
      debian|ubuntu*)
        sudo apt-get remove -y docker docker-engine docker.io docker-ce
        sudo apt-get update
        sudo apt-get install -y curl;;
      *)
        echo "unknown: $OSTYPE"
        exit 1;;
    esac

    curl -fsSL get.docker.com -o /tmp/get-docker.sh
    sudo sh /tmp/get-docker.sh
    sudo usermod -aG docker $(whoami)
}