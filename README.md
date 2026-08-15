# Xulu

CLI toolkit for inspecting and working with structured data files.

Xulu provides fast, content-aware inspection of Parquet, JSON, and delimited text files from the command line. Validation, profiling, diff, and conversion tools are planned.

This repository contains **documentation and release binaries**. Source code is developed privately.

## Current status

Xulu is currently an early preview. The first available command is **`xulu inspect`**, for inspecting the structure and metadata of data files.

Currently recognized formats:

- **Parquet**
- **JSON** / **JSONL** (NDJSON)
- **CSV** (comma-separated)
- **TSV** (tab-separated)
- **SSV** (semicolon-separated)
- **PSV** (pipe-separated)

Basic inspection—including path, size, timestamps, and other filesystem metadata—works for any readable file. Content that cannot be confidently recognized is reported as `unknown`.

## Installation

Linux x86_64 only for now.

### Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | bash
```

Works the same for **bash** and **zsh**.

- Installs into `~/.local/bin/xulu` (no sudo)
- Offers to update `~/.bashrc` or `~/.zshrc` (from `$SHELL`) for new terminals

`curl | bash` cannot change your current shell’s PATH. After install, do **one** of:

1. `source ~/.local/share/xulu/env.sh`, or
2. open a new terminal (if you answered `y` to the PATH prompt)

Then:

```bash
xulu --help
```

Pin a version:

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | XULU_VERSION=v0.1.0 bash
```

### Manual install

Use `~/.local/bin` (same as the script). That directory is user-writable, so later `xulu update` works without sudo.

1. Download `xulu-linux-x86_64` (and optionally `xulu-linux-x86_64.sha256`) from the latest
   [GitHub release](https://github.com/xuluhq/xulu/releases/latest).
2. Install onto your `PATH`:

```bash
chmod +x xulu-linux-x86_64
mkdir -p ~/.local/bin
mv xulu-linux-x86_64 ~/.local/bin/xulu
```

Optional checksum check (run in the download directory):

```bash
sha256sum -c xulu-linux-x86_64.sha256
# then rename/move as above if the file is still named xulu-linux-x86_64
```

3. If `xulu` is not found in a **new** terminal, add this to `~/.bashrc` (bash) or
   `~/.zshrc` (zsh) — not only `~/.profile`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Then open a new terminal (or `source ~/.bashrc` / `source ~/.zshrc`).

4. Check:

```bash
xulu --help
xulu --version
```

`-v` is also supported.

## Usage

```bash
xulu --help
xulu --version          # or: xulu -v
xulu inspect path/to/file.parquet
xulu inspect path/to/file.csv
xulu inspect path/to/file.json
xulu inspect path/to/file.jsonl
xulu inspect path/to/file.parquet --detailed
xulu inspect path/to/file.csv --detailed --format json
xulu inspect path/to/file.json --detailed --depth 5 --max-keys 64
xulu inspect path/to/file.json --detailed --max-keys 0  # all keys within depth
```

`inspect` always reports filesystem metadata (path, size, timestamps, and so on). It also tries to recognize the format from **file content** (not only the extension). With `--detailed`, supported formats get format-specific structural information, such as Parquet schema and layout details, delimited-text row and column information, or a JSON structural summary. It does not print row values.

Supported formats for recognition and detailed inspection: **Parquet**; **JSON**; **JSONL** (also `.ndjson`); **CSV** (comma-separated), **TSV** (tab-separated), **SSV** (semicolon-separated), and **PSV** (pipe-separated). For JSON structure, `--depth` / `--max-keys` apply (`--max-keys 0` means unlimited keys within the selected depth). A mismatched or missing extension may produce a warning when a format is detected. Content that cannot be confidently recognized is reported as `unknown`.

## Updating

If `xulu` lives in a user-writable location (the default `~/.local/bin` from `install.sh`), update in place:

```bash
xulu update          # prompt, then download and install the latest release
xulu update -y       # install without prompting
xulu update --check  # only report whether an update is available
```

`update` shows the current and latest versions, asks for confirmation (`[Y/n]`; Enter or `y` installs), verifies the published SHA-256 checksum, then replaces the binary. Use `-y` / `--yes` to skip the prompt (for scripts). It does not use sudo. Manual installs should also use `~/.local/bin` so `xulu update` can replace the binary without elevated permissions. If the binary is in a system path (for example `/usr/local/bin`), reinstall with `install.sh` into `~/.local/bin` instead.

## Roadmap

- More inspect formats and richer delimited-text details
- Tools for validation, profiling, diff, and conversion
