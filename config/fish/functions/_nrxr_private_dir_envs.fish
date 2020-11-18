function _nrxr_private_dir_envs \
  --description "source private environment variables when the folder is changed" \
  --on-variable PWD 

  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config

  if test -f $XDG_CONFIG_HOME/fish/private_variable_dirs
    source $XDG_CONFIG_HOME/fish/private_variable_dirs
  end
end
