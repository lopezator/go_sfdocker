#!/usr/bin/env bash

clear_inst() {
    case $1 in
      debian|ubuntu*)
        sudo apt-get remove docker docker-engine docker.io;;
      *)
        echo "unknown: $OSTYPE"
        exit 1;;
    esac
}