#!/usr/bin/env sh

if uname -o | grep -q "Darwin"; then
  OS='mac'
elif uname -o | grep -q -i linux; then
  OS='linux'
fi

runrcup() {
  printf "running rcup...\n"
  rcup -d . \
    -v -t fish \
    -x README*.md -x LICENSE -x pre-setup.sh
}

isinstalled=$(command -v rcup)

if [ "${OS}" = "mac" ]; then
  if [ "$isinstalled" = "rcup not found" ]; then
    if command -v brew; then
      printf "will install rcm with brew...\n"
      {
        brew tap thoughtbot/formulae
        brew install rcm
      }
    else
      printf "please check in https://github.com/thoughtbot/rcm how to install rcm in your system\n"
      exit
    fi
  fi
  runrcup
elif [ "${OS}" = "linux" ]; then
  if [ "$isinstalled" = "rcup not found" ]; then
    if command -v xbps-install; then
      printf "will install rcm with xbps...\n"
      sudo xbps-install -S rcm
    elif command -v apk; then
      printf "will install rcm with apk...\n"
      sudo apk add rcm
    elif command -v apt; then
      printf "will install rcm with xbps...\n"
      sudo apt install rcm
    else
      printf "please check in https://github.com/thoughtbot/rcm how to install rcm in your system\n"
      exit
    fi
  fi
  runrcup
else
  printf "Don't know what to do in the current OS"
fi
