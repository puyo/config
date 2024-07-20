[ -f "$HOME/.profile" ] && source "$HOME/.profile" # Load the default .profile

paths=(
  "$HOME/.mix_completions.bash"
)

for p in ${paths[@]}; do
  if [ -f "$p" ]; then
    source "$p"
  fi
done

source "$HOME/.bashrc"
