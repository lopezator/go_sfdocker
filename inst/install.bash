#!/usr/bin/env bash

source ./os.bash
source prepare.bash
source ./linux.bash

OS=$(detect_os)
prepare_inst ${OS}