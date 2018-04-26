#!/usr/bin/env bash

function detect_distro() {
    cat /etc/*-release | grep -o '^ID=[^,]*' | awk -F'[=&]' '{print $2}'
}

function detect_os() {
    case "$OSTYPE" in
      solaris*)
        OS="SOLARIS"
        echo "OS not supported"
        exit 1;;
      darwin*)
        OS="OSX"
        echo "OS not supported"
        exit 1;;
      linux*)
        echo $(detect_distro);;
      bsd*)
        OS="BSD"
        echo "OS not supported"
        exit 1;;
      *)
        OS="unknown: $OSTYPE"
        echo "OS not supported"
        exit 1;;
    esac
}