#!/usr/bin/env bash
# Install the Xulu CLI (Linux x86_64) from GitHub Releases.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/main/install.sh | bash
#
# Optional:
#   XULU_VERSION=v0.1.0 bash install.sh   # pin a release tag
#   INSTALL_DIR=~/.local/bin bash install.sh

set -euo pipefail

REPO="xuluhq/xulu"
ASSET="xulu-linux-x86_64"
INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/bin}"
VERSION="${XULU_VERSION:-}"

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "error: '${1}' is required" >&2
    exit 1
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

if ! command -v xulu >/dev/null 2>&1; then
  echo
  echo "Xulu is installed but not on your PATH yet."
  echo "Add this to ~/.bashrc or ~/.zshrc, then open a new terminal:"
  echo
  echo "  export PATH=\"${INSTALL_DIR}:\$PATH\""
  echo
else
  echo
  xulu --help | head -n 5 || true
  echo
  echo "Run 'xulu --help' to get started."
fi
