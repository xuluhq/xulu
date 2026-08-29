# Xulu

**Local CLI for file inspection, file diffing, and (soon) file validation** of structured data — CSV, JSON, JSONL, Parquet, and plain text.

Xulu helps you understand and compare data files **on your machine**: detect formats, inspect schemas and metadata, and diff two datasets with CI-friendly exit codes. No account required for inspect and diff today.

This repository holds **releases, the install script, and documentation links**. Source code is developed privately. The Software is **proprietary** — see [TERMS.md](./TERMS.md) and [LICENSE](./LICENSE).

## What’s available today

| Command | Purpose |
|---------|---------|
| [`xulu inspect`](#inspect--file-inspection) | **File inspection** — format detection, schemas, metadata, and structural summaries |
| [`xulu diff`](#diff--file-diffing) | **File diffing** — compare two files (CSV, JSON, Parquet, text) with clear reports |
| `xulu update` | Update the CLI from GitHub Releases (checksum-verified) |
| `xulu changelog` | Show release notes |

**Coming soon:** **file validation** (`validate` and related tooling), more CLI capabilities, a platform for managing reports, and scheduled checks — documented as they ship. Inspect and diff remain free to use today; future editions will be described before anything moves behind a paid tier.

### Formats

- **Parquet** — schema and layout inspection; row-level diff
- **JSON** / **JSONL** (NDJSON) — structure inspection; structural / record diff
- **Delimited text** — CSV, TSV, SSV (semicolon), PSV (pipe), and related layouts
- **Plain text** — line-oriented inspection and diff

Basic filesystem metadata (path, size, timestamps) works for any readable file. Unrecognized content is reported as `unknown`.

## Links

- [GitHub Releases](https://github.com/xuluhq/xulu/releases) — binaries + SHA-256 checksums
- [Terms of Use](./TERMS.md) — license and liability for the CLI binary
- Docs and marketing sites will link here once deployed (getting started, command reference, changelog)

## Installation

**Linux x86_64** today. By downloading or using the CLI, you agree to the [Terms of Use](./TERMS.md).

### Other platforms (coming soon)

- Other Linux architectures (e.g. **arm64**)
- Distro packages (e.g. **Fedora** / RPM-style, and similar for other distributions)
- **macOS** and **Windows** builds

### Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | bash
```

Works with **bash** and **zsh**.

- Installs into `~/.local/bin/xulu` (no sudo)
- Offers to update `~/.bashrc` or `~/.zshrc` for new terminals
- Verifies the published SHA-256 checksum when available

`curl | bash` cannot change your current shell’s PATH. After install, do **one** of:

1. `source ~/.local/share/xulu/env.sh`, or
2. open a new terminal (if you answered `y` to the PATH prompt)

Then:

```bash
xulu --version   # or: xulu -v
xulu --help
```

Pin a version:

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | XULU_VERSION=v0.2.6 bash
```

### Manual install

1. Download `xulu-linux-x86_64` and `xulu-linux-x86_64.sha256` from the latest
   [GitHub release](https://github.com/xuluhq/xulu/releases/latest).
2. Verify and install:

```bash
sha256sum -c xulu-linux-x86_64.sha256
chmod +x xulu-linux-x86_64
mkdir -p ~/.local/bin
mv xulu-linux-x86_64 ~/.local/bin/xulu
```

3. Ensure `~/.local/bin` is on your PATH (e.g. in `~/.bashrc` or `~/.zshrc`):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Use `~/.local/bin` so later `xulu update` can replace the binary without sudo.

## Inspect — file inspection

Detect format and print schema / metadata:

```bash
xulu inspect results.parquet
xulu inspect export.csv --detailed
xulu inspect data.json --detailed -r json --pretty
xulu inspect big.jsonl --detailed -o report.txt
```

Useful flags: `--detailed`, `--depth`, `--max-keys`, `-o` / `--output`, `--full`, `--limit-stdout`, `--no-compact`, `-r` / `--report` (`txt` or `json`), `--pretty`.

## Diff — file diffing

Compare two datasets:

```bash
xulu diff yesterday.csv today.csv
xulu diff baseline.json result.json -o report.txt
xulu diff notes.txt notes.copy.txt -A myers
xulu diff a.parquet b.parquet -r json --pretty
```

Useful flags: `-A` / `--algorithm` (`positional` or `myers`), `-o` / `--output`, `--full`, `--max-differences`, `--limit-stdout`, `-r` / `--report`, `--pretty`, `--color`.

Exit code is non-zero when differences are found — suitable for CI.

## Updating

```bash
xulu update          # prompt, then install latest
xulu update -y       # no prompt
xulu update --check  # report only
```

Updates verify the published SHA-256 checksum, then replace the binary in place.

## License and terms

- **[TERMS.md](./TERMS.md)** — Terms of Use (proprietary license, Swiss governing law, liability exclusions). **Read this before use.**
- **[LICENSE](./LICENSE)** — short proprietary notice pointing at TERMS.md

The CLI is a **local analysis and reporting tool**: it reads your files and writes reports; it does not modify the input files being inspected or diffed as part of normal operation.

## Keywords

file inspection · file diffing · file validation (coming soon) · parquet schema · csv diff · json diff · parquet diff · structured data CLI · local data tooling · data file comparison
