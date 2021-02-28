# make sure fisher is installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if functions -q _nrxr_private_dir_envs
  _nrxr_private_dir_envs
end

# aliases
alias vim='nvim'
alias tmux 'env TERM=screen-256color-bce tmux'

if uname -a | grep -q "Darwin"
  set os 'mac'
else if uname -a | grep -q -i linux
  set os 'linux'
end

# setting up paths
#
# the standards
set -x PATH $PATH /usr/local/{bin/sbin}

# on macOS, install the /usr/local paths for homebrew
if test $os = 'mac'
  if test -d /usr/texbin
    set -x PATH $PATH /usr/texbin
  end

  if command -v brew > /dev/null
    set -x PATH $PATH (brew --prefix)/bin

    set git_prefix (brew --prefix git)
    if test -d $git_prefix
      set -x PATH $PATH $git_prefix/share/git-core/contrib/diff-highlight
    end

    set coreutils_prefix (brew --prefix coreutils)
    if test -d $coreutils_prefix
      set -x PATH $PATH $coreutils_prefix/libexec/gnubin
    end

    set gnused_prefix (brew --prefix gnu-sed)
    if test -d $gnused_prefix
      set -x PATH $PATH $gnused_prefix/libexec/gnubin
    end

    set icu4c_prefix (brew --prefix icu4c)
    if test -d $icu4c_prefix
      set -x PATH $PATH $icu4c_prefix/{bin,sbin}
    end

    set libffi_prefix
    if test -d $libffi_prefix
      set -gx LDFLAGS "-L"$libffi_prefix"/lib"
      set -gx PKG_CONFIG_PATH $libffi_prefix"/lib/pkgconfig"
    end
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

if test -d ~/code/usr
  if test -d ~/code/usr/bin
    set -x PATH $PATH ~/code/usr/bin
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
