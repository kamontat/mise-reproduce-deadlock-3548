set -e

# export MISE_JOBS=1
mise="$HOME/.local/bin/mise"
if [ -f "$mise" ]; then
  # eval "$("$mise" activate zsh)"

  eval "$("$mise" activate zsh --no-hook-env)"
  mise hook-env --trace --yes --raw

  mise install go
fi

unset mise
