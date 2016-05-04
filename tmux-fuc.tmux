#!/usr/bin/env bash

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option")

  if [[ -z $option_value ]]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

readonly fuc_key="$(get_tmux_option "@fuc-key" "e")"
readonly fuc_path="$(get_tmux_option "@fuc-path" "${HOME}/.fuc")"

if [ "$(uname)" == 'Darwin' ]; then
  #mac
  copy_command='pbcopy -'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  #linux
  copy_command='xsel --clipboard --input'
fi

tmux bind-key "$fuc_key" \
  split-window -l 10 "grep -hE '^\\$' ${fuc_path}/*.md | sed 's/^\\$ //' | peco | ${copy_command}"

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=sh sw=2 ts=2 et
