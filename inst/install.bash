#!/usr/bin/env bash

SUPPORTED_DISTROS="debian|ubuntu|fedora|centos"

function detect_distro() {
    cat /etc/*-release | grep -o '^ID=[^,]*' | awk -F'[=&]' '{print $2}'
}

function detect_os() {
    case $1 in
      solaris*)
        OS="SOLARIS";;
      darwin*)
        OS="OSX";;
      linux*)
        OS=$(detect_distro);;
      bsd*)
        OS="BSD";;
      *)
        OS="unknown: $OSTYPE";;
    esac
}

prepare_inst() {
    case $1 in debian|ubuntu*)
        sudo apt-get remove -y docker docker-engine docker.io docker-ce
        sudo apt-get update
        sudo apt-get install -y curl;;
    *)
        echo "unknown OS: $OSTYPE not supported"
        exit 1;;
    esac
}

function install_docker() {
    case $1 in ${SUPPORTED_DISTROS}*)
        curl -fsSL get.docker.com -o /tmp/get-docker.sh
        sudo sh /tmp/get-docker.sh
        sudo usermod -aG docker $(whoami);;
    *)
        echo "unknown: $OSTYPE"
        exit 1;;
    esac
}

function get_latest_compose_version() {
    curl https://api.github.com/repos/docker/compose/releases/latest -s | grep "tag_name" | awk -F'[:&]' '{print $2}' | tr -d \",
}

function install_docker_compose() {
    case $1 in ${SUPPORTED_DISTROS}*)
        sudo curl -L https://github.com/docker/compose/releases/download/$(get_latest_compose_version)/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose;;
    *)
        echo "unknown: $OSTYPE"
        exit 1;;
    esac
}

detect_os $OSTYPE
prepare_inst ${OS}
install_docker ${OS}
install_docker_compose ${OS}


