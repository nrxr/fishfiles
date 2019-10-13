# make sure fisher is installed
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# aliases
alias vim='nvim'
alias tmux 'env TERM=xterm-256color tmux'

if uname -o | grep -q "Darwin"
  set os 'mac'
else if uname -o | grep -q -i linux
  set os 'linux'
end

# setting up paths
#
# the standards
set -U fish_user_paths $fish_user_paths /usr/local/{bin/sbin}

# on macOS, install the /usr/local paths for homebrew
if test $os = 'mac'
  set -U fish_user_paths $fish_user_paths /usr/local/opt/{coreutils,gnu-sed}/libexec/gnubin \
    /usr/local/opt/git/share/git-core/contrib/diff-highlight

  if test -d /usr/local/opt/icu4c/bin
    set -U fish_user_paths $fish_user_paths /usr/local/opt/icu4c/{bin,sbin}
  end

  if test -d /usr/texbin
    set -U fish_user_paths $fish_user_paths /usr/texbin
  end
end

# on linux load some special paths
if test $os = 'linux'
  if test -f /usr/share/doc/git/contrib/diff-highlight/diff-highlight
    set -U fish_user_paths $fish_user_paths /usr/share/doc/git/contrib/diff-highlight
  end

  if test -f /usr/share/git/diff-highlight/diff-highlight
    set -U fish_user_paths $fish_user_paths /usr/share/git/diff-highlight
  end
end

# the go-based
if test -d ~/code/bin
  set -U fish_user_paths $fish_user_paths ~/code/bin
end

if test -f ~/.config/fish/private
  source ~/.config/fish/private
end

if test -f ~/.config/fish/envs
  source ~/.config/fish/envs
end
