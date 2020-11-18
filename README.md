# fishfiles

These are configuration files for `fish` and an "ideal" terminal setup according
to my needs. What comes with what I like? A nice looking terminal －which the
prompt `pure` will provide－ and good-enough configurations.

This repository comes with a simple `install.sh` script that as the name says so
it'll take care of installing the required packages in `macOS` with `brew` or in
a linux distro that has either: `apt`, `apk`, `xbps-install` or `pacman` (in
which case it'll install `yay` and use that to install things, using AURs if
needed).

## Pre-requisites

Clone into your terminal:

    git clone git://github.com/nrxr/fishfiles.git \
      ~/code/src/github.com/nrxr/fishfiles

Have an interpreter for `sh`.

## Installing

Run on a sh-compatible terminal:

    ./install.sh

This will install (hopefully) `rcm` if you don't have it and then configure
everything with it using the tag `fish`.

If you want to update, then pull from the git repository and run the
`install.sh` script again.

## What comes with this configuration

- `fish`
- [pure prompt](https://github.com/rafaelrinaldi/pure)
- set of basic envs on `~/.config/fish/envs` with `nvim` as `EDITOR`,
  `screen-256color-bce` as `TERM`, `less` as `PAGER` and `GO111MODULE on`.
- support for private envs in `~/.config/fish/private`, it expects them in the
  `fish` fashion so `set -Ux NAME 'value'`. Values I save there are things like
  `GOPRIVATE` and such.
- support for private envs based on current directory in
  `~/.config/fish/private_variable_dirs`. Example:

 ```fish
 set --erase NPM_TOKEN
 if string match -q --regex 'code\/src\/github\.com\/nrxr' $PWD
   set -gx NPM_TOKEN a-valid-token
 end
 ```

## Installing the `nvim` configuration files with `rcm`

    rcup -d $HOME/code/src/github.com/nrxr/fishfiles \
      -v -t fish \
      -x README*.md -x LICENSE -x pre-setup.sh -x install.sh

## License

© 2019-2020, nrxr `<nrxr@disroot.org>`.
Released under the MIT license terms.
