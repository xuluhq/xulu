# Xulu

CLI toolkit for data quality on structured files.

Inspect, validate, profile, compare, and convert datasets from one command: `xulu`.

This repository distributes **documentation and release binaries**.
Source code is developed privately.

## Current status

Early preview. The first available command is **inspect** (`xulu inspect`) for understanding structured files. More commands will ship over time.

Today, Parquet is the only supported inspect format.

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
   [Release](https://github.com/xuluhq/xulu/releases/latest).
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

## Usage

```bash
xulu --help
xulu inspect path/to/file.parquet
xulu inspect path/to/file.parquet --detailed
xulu inspect path/to/file.parquet --detailed --format json
```

`inspect` reports format, size, schema, and (with `--detailed`) format-specific metadata. It does not print row values.

## Updating

If `xulu` lives in a user-writable location (the default `~/.local/bin`), update in place:

```bash
xulu update          # download and install the latest release
xulu update --check  # only report whether an update is available
```

`update` verifies the published SHA-256 checksum before replacing the binary. It does not use sudo. If the binary is in a system path (for example `/usr/local/bin`), reinstall with `install.sh` into `~/.local/bin` instead.

## Roadmap

- More inspect formats
- Tools for validation, profiling, file diff, and conversion
