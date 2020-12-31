''
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'

  alias xclip='xclip -selection c'
  alias rs="exec -l $SHELL"

  sys() {
    PATH="/run/wrappers/bin:/run/current-system/sw/bin:/run/current-system/sw/sbin" $@
  }

  ops() {
    eval $(op signin "$1")
  }

  hmu() {
    nix run --impure github:mammothbane/dotfiles/master
  }

  neuron() {
    command neuron -d "$HOME/.local/neuron" "$@"
  }
''
