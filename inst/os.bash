#!/usr/bin/env bash

function detect_distro() {
    cat /etc/*-release | grep -o '^ID=[^,]*' | awk -F'[=&]' '{print $2}'
}

function detect_os() {
    case "$OSTYPE" in
      solaris*)
        echo "SOLARIS"
        exit 1;;
      darwin*)
        echo "OSX"
        exit 1;;
      linux*)
        detect_distro;;
      bsd*)
        echo "BSD"
        exit 1;;
      *)
        echo "unknown: $OSTYPE"
        exit 1;;
    esac
}