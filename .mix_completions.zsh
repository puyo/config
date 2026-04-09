_mix() {
  local -a tasks
  if [[ -f mix.exs ]]; then
    tasks=(${(f)"$(mix help --names 2>/dev/null)"})
    _describe 'mix tasks' tasks
  fi
}
compdef _mix mix
