# Set PATH, MANPATH, INFOPATH from Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Configurations
export BAT_THEME=OneHalfDark
export GREP_OPTIONS="--color=always"
export CLI_COLOR=1

# Additional PATHs
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin"

# Aliases
alias ls="eza"
alias ll="eza -l --color=always --header --git --time-style=long-iso"
alias cat="bat"

# Functions
mkcd() {
  mkdir -p "$*"
  cd "$*"
}

treeco() {
  if [ -z "$1" ]; then
    echo "Usage: treeco <name> [<branch>]"
    return 1
  fi

  current_dir=$(basename "$(pwd)")
  target="$current_dir.$1"
  target_path="../$target"

  if [ ! -d "$target_path" ]; then
    if [ -z "$2"]; then
      target_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    else
      target_branch=$2
    fi
    if [ -z "$target_branch" ]; then
      echo "Target branch is not found!"
      return 1
    fi

    git worktree add "$target_path" "$target_branch"
  fi

  cd "$target_path" || return 1
}

# Additional init scripts
eval "$(starship init zsh)"
