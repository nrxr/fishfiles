# fishfiles

These are configurations for `fish`.

Run on a sh-compatible terminal (for a quick install):

    sh ./pre-setup.sh

This will install (hopefully) `rcm` if you don't have it and then configure
everything with it using the tag `fish`.

If you want to update, then pull from the git repository and run the
`pre-setup.sh` script again.

If you want to know what's happening inside (or are using a linux different than
voidlinux), then:

## What comes with this configuration

- [pure prompt](https://github.com/rafaelrinaldi/pure)
- set of envs on `~/.config/fish/envs`
- can load private exports from `~/.config/fish/private`, it expects them in the
  `fish` fashion so `set -Ux NAME 'value'`

## Pre-requisites

Clone into your terminal:

    git clone git://github.com/nrxr/fishfiles.git \
      ~/code/src/github.com/nrxr/fishfiles

Install [`rcm`](https://github.com/thoughtbot/rcm):

    # macOS
    brew tap thoughtbot/formulae
    brew install rcm

    # voidlinux
    sudo xbps-install -S rcm

## Installing the `nvim` configuration files with `rcm`

    rcup -d $HOME/code/src/github.com/nrxr/fishfiles \
      -v -t fish \
      -x README*.md -x LICENSE -x pre-setup.sh

Manually updating can be done by running `pre-setup.sh` again or this same line.

## License

© 2019, nrxr `<nrxr@disroot.org>`. Released under the MIT license terms.
