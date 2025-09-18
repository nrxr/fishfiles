if functions -q _nrxr_private_dir_envs
  _nrxr_private_dir_envs
end

# aliases
alias vim 'nvim'
alias tmux 'env TERM=tmux-256color tmux'
alias tig 'env TERM=xterm-256color tig --show-signature'

if uname -a | grep -q "Darwin"
  set os 'mac'
else if uname -a | grep -q -i linux
  set os 'linux'
end

# setting up paths

if test -d ~/.cargo/bin
  set -x PATH $PATH ~/.cargo/bin
end

# on macOS, install the /usr/local paths for homebrew
if test $os = 'mac'
  if test -f ~/.claude/local/node_modules/.bin/claude
    set -x PATH $PATH ~/.claude/local/node_modules/.bin
  end

  if test -d /usr/texbin
    set -x PATH $PATH /usr/texbin
  end

  if test -d /opt/homebrew/bin
    set -x PATH /opt/homebrew/bin $PATH
  end

  if test -d /opt/homebrew/opt/python@3.12/libexec/bin
    set -x PATH $PATH /opt/homebrew/opt/python@3.12/libexec/bin
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

    if test -d /opt/homebrew/opt/curl/bin
      fish_add_path /opt/homebrew/opt/curl/bin
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

    set java_prefix (brew --prefix java)
    if test -d $java_prefix
      fish_add_path $java_prefix/bin
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

if test -d ~/code/src
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

# Set GPG_TTY to avoid the error:
#   gpg: signing failed: Inappropriate ioctl for device
#
# Ref: https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html#Invoking-GPG_002dAGENT
set -gx GPG_TTY (tty)

# the standard is set at the end, so things like Docker for Mac can't
# hijack the versions installed via Go or Homebrew.
set -x PATH $PATH /usr/local/{bin/sbin}

if test -f ~/.config/fish/private
  source ~/.config/fish/private
end

if test -f ~/.config/fish/envs
  source ~/.config/fish/envs
end

# pure-fish/fish settings
set --universal pure_enable_container_detection false
set --universal pure_enable_single_line_prompt false
set --universal pure_shorten_prompt_current_directory_length 36
set --universal pure_truncate_prompt_current_directory_keeps 2
set --universal pure_symbol_git_dirty •

alias claude="/Users/nrxr/.claude/local/claude"

starship init fish | source
