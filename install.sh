#!/usr/bin/env sh

# runrcup is the core logic for running rcup and setting up correctly the
# configuration files.
runrcup() {
  printf "running rcup...\n"
  rcup -d . \
    -v -t fish \
    -x README*.md -x LICENSE -x pre-setup.sh -x install.sh
}

checkPreSetup() {
  if [ ! -f pre-setup.sh ]; then
    if command -v curl; then
      curl -OL https://github.com/nrxr/quickconfig/raw/master/pre-setup.sh
    elif command -v wget; then
      wget https://github.com/nrxr/quickconfig/raw/master/pre-setup.sh
    else
      printf "Please, download the file https://github.com/nrxr/quickconfig/raw/master/pre-setup.sh\n"
    fi
  fi
}

installFn() {
  checkPreSetup
  sh ./pre-setup.sh setup
  runrcup
}

installFn "$@"
