#!/usr/bin/env sh

set -e

# Verbose logging
log_prefix="\e[30m[\e[36mDeNic0la\e[30m/\e[35mtoolbox\e[30m/\e[33moh-my-posh \e[34msetup\e[30m]\e[0m"
CONFIG_FILE=""
CLONE_PATH=""
OMP_INSTALL_DIR=""
log() {
  printf "${log_prefix} %s\n" "$*"
}

# Ask the user how to load the config
echo "Do you want to clone the toolbox repo or use the files from GitHub as URLs?"
echo "1) Clone toolbox repo"
echo "2) Use default config URL (default)"
echo "Enter choice [1/2]: "
read -r user_choice

case "$user_choice" in
  1) USE_TOOLBOX=true ;;
  2|"") USE_TOOLBOX=false ;;
  *) log "\e[31m\e[1mInvalid choice. \e[0m\e[34mDefaulting to \e[30m'\e[33mUse default config URL\e[30m'\e[34m."; USE_TOOLBOX=false ;;
esac

ensure_omp_install_dir() {
  if command -v oh-my-posh >/dev/null 2>&1; then
    return 0
  fi

  if [ -n "$install_dir" ]; then
    OMP_INSTALL_DIR=$install_dir
    return 0
  fi

  if [ -d "$HOME/bin" ] && [ -w "$HOME/bin" ]; then
    install_dir="$HOME/bin"
    log "Using \033[33m$install_dir\033[0m for installation of \033[33moh-my-posh"
    OMP_INSTALL_DIR=$install_dir
    return 0
  fi

  if ([ -d "$HOME/.local/bin" ] && [ -w "$HOME/.local/bin" ]) || mkdir -p "$HOME/.local/bin" >/dev/null 2>&1; then
    install_dir="$HOME/.local/bin"
    log "Using \033[33m$install_dir\033[0m for installation of \033[33moh-my-posh"
    OMP_INSTALL_DIR=$install_dir
    return 0
  fi

  OMP_INSTALL_DIR="./"
  log "\033[31mNo Installation dir was suitable, missing dir or missing write permissions."
  return 1
}

get_clone_path() {
  if [ -n "$CLONE_PATH" ]; then
    log "\033[33mUsing existing clone path: $CLONE_PATH\033[0m"
    return 0
  fi

  log "\033[1mPlease specify a directory (parent directory of toolbox) to clone the toolbox repo into:\033[0m"
  printf "Clone path (absolute): "
  read -r entered_clone_path
  mkdir -p "$entered_clone_path"

  if [ -d "$entered_clone_path" ] && [ -w "$entered_clone_path" ]; then
    CLONE_PATH=$entered_clone_path
    return 0
  else
    log "\033[31m\033[1mCannot write to the specified directory.\033[0m"
    exit 1
  fi
}

prepare_get_config() {
  if [ "$USE_TOOLBOX" = true ]; then
    log "Searching for \033[35mtoolbox\033[0m repo with \033[33moh-my-posh\033[0m config..."

    found_path=$(find "$HOME" -type f -path "*/toolbox/oh-my-posh/default.omp.json" 2>/dev/null | head -n 1)

    if [ -n "$found_path" ]; then
      CONFIG_FILE=$found_path
      log "\033[32mFound config at:\033[0m $CONFIG_FILE"
      return 0
    else
      log "\033[33mNo existing Config found"
      attempt=0
      max_tries=3
      while ! get_clone_path; do
        log "\033[31m\033[1mNo valid path for repo is set.\033[0m"
        attempt=$((attempt + 1))
        [ "$attempt" -ge "$max_tries" ] && CLONE_PATH="$HOME" && break
      done
    fi
  else
    CONFIG_FILE="https://raw.githubusercontent.com/DeNic0la/toolbox/refs/heads/master/oh-my-posh/default.omp.json"
  fi
}

get_config() {
  [ -n "$CONFIG_FILE" ] && log "\033[33mUsing existing config file: $CONFIG_FILE\033[0m" && return 0
  clone_toolbox_repo
}


clone_toolbox_repo() {
  repo_ssh="git@github.com:DeNic0la/toolbox.git"
  repo_https="https://github.com/DeNic0la/toolbox.git"

  log "Cloning toolbox using SSH..."
  if git clone "$repo_ssh" "$CLONE_PATH/toolbox" 2>/dev/null; then
    log "Cloned using SSH"
  else
    log "\033[33mSSH clone failed, falling back to HTTPS..."
    if git clone "$repo_https" "$CLONE_PATH/toolbox"; then
      log "Cloned using HTTPS"
    else
      log "\033[31mError: Cloning toolbox repo failed."
      exit 1
    fi
  fi

  if [ -f "$CLONE_PATH/toolbox/oh-my-posh/default.omp.json" ]; then
    CONFIG_FILE="$CLONE_PATH/toolbox/oh-my-posh/default.omp.json"
    log "Using config from cloned toolbox: $CONFIG_FILE"
  else
    log "\033[31m\033[1mError: Config file not found in cloned toolbox repo.\033[0m"
    exit 1
  fi
}


check_omp_installation() {
  if ! command -v oh-my-posh >/dev/null 2>&1; then
    log "Installing \033[33moh-my-posh\033[0m..."
    curl -s https://ohmyposh.dev/install.sh | sh -s
  else
    log "\033[33moh-my-posh already installed ?"
  fi

  for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc" ] && ! grep "$OMP_INSTALL_DIR" "$rc" >/dev/null 2>&1; then
      echo "export PATH=\"$OMP_INSTALL_DIR:\$PATH\"" >> "$rc"
      log "Added $OMP_INSTALL_DIR to PATH in $rc"
    fi
  done
}

append_if_missing() {
  rcfile="$1"
  shell="$2"
  line="eval \"\$(oh-my-posh init $shell --config $CONFIG_FILE)\""

  if [ -f "$rcfile" ] && ! grep -F "$line" "$rcfile" >/dev/null 2>&1; then
    echo "" >> "$rcfile"
    echo "$line" >> "$rcfile"
    log "Added oh-my-posh init to $rcfile"
  fi
}

# Main
ensure_omp_install_dir
prepare_get_config
get_config & check_omp_installation

if command -v bash >/dev/null 2>&1; then
  append_if_missing "$HOME/.bashrc" "bash"
fi
if command -v zsh >/dev/null 2>&1; then
  append_if_missing "$HOME/.zshrc" "zsh"
fi



# Add to bash and zsh if available
if command -v bash &> /dev/null; then
  append_if_missing "$HOME/.bashrc" "bash"
fi
if command -v zsh &> /dev/null; then
  append_if_missing "$HOME/.zshrc" "zsh"
fi

SHELL_NAME=$(ps -p $$ -o comm= 2>/dev/null || basename "$SHELL")
SHELL_RC="${SHELL_NAME}rc"
printf "\e[32mDone. \e[34mMaybe you need to Restart your terminal or run: \e[0msource ~/.%src\n" "$SHELL_RC"
#log "\e[32mDone. \e[34mMaybe you need to Restart your terminal or run: \e[0msource ~/.$SHELL_RC"


eval "$(oh-my-posh init "$SHELL_NAME" --config "$CONFIG_FILE")"
exec "$SHELL"

