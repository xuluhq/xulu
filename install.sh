#!/usr/bin/env bash
# Install the Xulu CLI (Linux x86_64) from GitHub Releases.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | bash
#
# Optional:
#   XULU_VERSION=v0.1.0 bash install.sh   # pin a release tag
#   INSTALL_DIR=~/.local/bin bash install.sh

set -euo pipefail

REPO="xuluhq/xulu"
ASSET="xulu-linux-x86_64"
INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/bin}"
VERSION="${XULU_VERSION:-}"
PATH_LINE="export PATH=\"${INSTALL_DIR}:\$PATH\""

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "error: '${1}' is required" >&2
    exit 1
  fi
}

path_contains_install_dir() {
  case ":${PATH}:" in
    *":${INSTALL_DIR}:"*) return 0 ;;
    *) return 1 ;;
  esac
}

default_rc_file() {
  case "${SHELL##*/}" in
    zsh) echo "${HOME}/.zshrc" ;;
    bash) echo "${HOME}/.bashrc" ;;
    *) echo "${HOME}/.bashrc" ;;
  esac
}

ask_yes_no() {
  local prompt="$1"
  local reply
  # When installed via `curl | bash`, stdin is the script — read from the terminal.
  if [[ -r /dev/tty ]]; then
    printf "%s" "${prompt}" > /dev/tty
    read -r reply < /dev/tty
  elif [[ -t 0 ]]; then
    printf "%s" "${prompt}"
    read -r reply
  else
    echo "n"
    return 1
  fi
  case "${reply}" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

print_manual_path_help() {
  echo
  echo "Add this to $(default_rc_file) (or your shell config), then open a new terminal:"
  echo
  echo "  ${PATH_LINE}"
  echo
}

maybe_configure_path() {
  if path_contains_install_dir; then
    echo
    echo "${INSTALL_DIR} is already on your PATH."
    return 0
  fi

  echo
  echo "Xulu is installed but ${INSTALL_DIR} is not on your PATH."
  echo

  if ask_yes_no "Add ${INSTALL_DIR} to PATH in $(default_rc_file)? [y/N] "; then
    local rc
    rc="$(default_rc_file)"
    touch "${rc}"
    if grep -Fq "${INSTALL_DIR}" "${rc}" 2>/dev/null; then
      echo "PATH entry for ${INSTALL_DIR} already present in ${rc}."
    else
      {
        echo ""
        echo "# Xulu CLI"
        echo "${PATH_LINE}"
      } >> "${rc}"
      echo "Added PATH export to ${rc}."
      echo "Open a new terminal (or run: source ${rc}) before using xulu."
    fi
  else
    echo "Skipped automatic PATH update."
    print_manual_path_help
  fi
}

need_cmd curl
need_cmd uname
need_cmd mktemp

os="$(uname -s)"
arch="$(uname -m)"

if [[ "${os}" != "Linux" ]]; then
  echo "error: this installer currently supports Linux only (got ${os})" >&2
  exit 1
fi

if [[ "${arch}" != "x86_64" && "${arch}" != "amd64" ]]; then
  echo "error: this installer currently supports x86_64 only (got ${arch})" >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

if [[ -n "${VERSION}" ]]; then
  # Accept v0.1.0 or 0.1.0
  tag="${VERSION}"
  [[ "${tag}" == v* ]] || tag="v${tag}"
  url="https://github.com/${REPO}/releases/download/${tag}/${ASSET}"
  echo "Downloading Xulu ${tag} (${ASSET})..."
else
  url="https://github.com/${REPO}/releases/latest/download/${ASSET}"
  echo "Downloading latest Xulu (${ASSET})..."
fi

curl -fsSL "${url}" -o "${tmpdir}/${ASSET}"
chmod +x "${tmpdir}/${ASSET}"

mkdir -p "${INSTALL_DIR}"
mv "${tmpdir}/${ASSET}" "${INSTALL_DIR}/xulu"

echo "Installed: ${INSTALL_DIR}/xulu"

maybe_configure_path

# Use the install dir for the smoke check even if PATH was not updated yet.
export PATH="${INSTALL_DIR}:${PATH}"
echo
if command -v xulu >/dev/null 2>&1; then
  xulu --help | head -n 5 || true
  echo
  echo "Run 'xulu --help' to get started."
fi
