# make sure fisher is installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# aliases
alias vim='nvim'
alias tmux 'env TERM=screen-256color-bce tmux'

if uname -o | grep -q "Darwin"
  set os 'mac'
else if uname -o | grep -q -i linux
  set os 'linux'
end

# setting up paths
#
# the standards
set -x PATH $PATH /usr/local/{bin/sbin}

# on macOS, install the /usr/local paths for homebrew
if test $os = 'mac'
  set -x PATH $PATH /usr/local/opt/{coreutils,gnu-sed}/libexec/gnubin \
    /usr/local/opt/git/share/git-core/contrib/diff-highlight

  if test -d /usr/local/opt/icu4c/bin
    set -x PATH $PATH /usr/local/opt/icu4c/{bin,sbin}
  end

  if test -d /usr/texbin
    set -x PATH $PATH /usr/texbin
  end

  if test -d /usr/local/opt/libffi/lib
    set -gx LDFLAGS "-L/usr/local/opt/libffi/lib"
    set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig"
  end
end

# on linux load some special paths
if test $os = 'linux'
  if test -f /usr/share/doc/git/contrib/diff-highlight/diff-highlight
    set -x PATH $PATH /usr/share/doc/git/contrib/diff-highlight
  end

  if test -f /usr/share/git/diff-highlight/diff-highlight
    set -x PATH $PATH /usr/share/git/diff-highlight
  end
end

# the go-based
if test -d ~/code/bin
  set -x PATH $PATH ~/code/bin
end

if test -d ~/code/src && test -d ~/code/bin
  set -x GOPATH ~/code
end

# for n node version manager
if test -d ~/code/n
  set -x N_PREFIX ~/code/n
  if test -d ~/code/n/bin
    set -x PATH ~/code/n/bin $PATH
  end
end

# the ghcup based
if test -d ~/.ghcup
  set -x PATH ~/.cabal/bin ~/.ghcup/bin $PATH
end

if test -f ~/.config/fish/private
  source ~/.config/fish/private
end

if test -f ~/.config/fish/envs
  source ~/.config/fish/envs
end
