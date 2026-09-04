# Xulu

**Xulu Data Quality**: local inspect and diff for structured files.

`xulu inspect` and `xulu diff` run on your machine against CSV, JSON, Parquet, and text. No account required today. Validation, CI checks, and tracking are next. This repo ships **releases, the install script, and docs links**; source stays private. Proprietary. See [TERMS.md](./TERMS.md) and [LICENSE](./LICENSE).

[xulu.dev](https://xulu.dev) · [docs.xulu.dev](https://docs.xulu.dev) · [Xulu Data Quality](https://xulu.dev/data-quality/)

## What’s available today

| Command | Purpose |
|---------|---------|
| [`xulu inspect`](#inspect-file-inspection) | Basics for any file; schemas for CSV, JSON, JSONL, Parquet |
| [`xulu diff`](#diff-file-diffing) | Compare two files; reports and CI-friendly exit codes |
| `xulu update` | Update from GitHub Releases (checksum-verified) |
| `xulu changelog` | Show release notes |

**Coming soon:** validation and more, documented as they ship. Inspect and diff are free in the current beta; editions will be clear before anything is paid.

### Formats

**Inspect (every readable file):** path, size, size on disk (when available), symlink, hidden, read-only, timestamps. Unknown content is labeled `unknown`; basics still print.

**Inspect (schemas with `--detailed`):** Parquet, JSON / JSONL, delimited text (CSV, TSV, SSV, PSV), plain text (line-oriented metadata).

**Diff:** Parquet (row-level), JSON / JSONL, delimited text, plain text.

## Links

- [Xulu Data Quality](https://xulu.dev/data-quality/)
- [Site](https://xulu.dev): install and task pages
- [Docs](https://docs.xulu.dev): getting started, commands, examples, changelog
- [Getting started](https://docs.xulu.dev/getting-started/)
- [Releases](https://github.com/xuluhq/xulu/releases): Linux x86_64 and arm64 + SHA-256
- [Terms](./TERMS.md)
- [docs llms.txt](https://docs.xulu.dev/llms.txt)

### Common tasks

| Task | Docs | Site |
|------|------|------|
| Inspect a Parquet schema | [example](https://docs.xulu.dev/examples/parquet-schema/) | [page](https://xulu.dev/parquet-schema) |
| Compare two CSV files | [example](https://docs.xulu.dev/examples/csv-diff/) | [page](https://xulu.dev/csv-diff) |
| Compare JSON / JSONL | [example](https://docs.xulu.dev/examples/json-diff/) | [page](https://xulu.dev/json-diff) |
| Inspect any file | [example](https://docs.xulu.dev/examples/file-inspection/) | [page](https://xulu.dev/file-inspection) |
| Diff structured files | [example](https://docs.xulu.dev/examples/file-diff/) | [page](https://xulu.dev/file-diff) |
| Validation (soon) | [example](https://docs.xulu.dev/examples/file-validation/) | [page](https://xulu.dev/file-validation) |

## Installation

**Linux x86_64** and **Linux arm64** today (install script auto-detects). By downloading or using the CLI, you agree to the [Terms of Use](./TERMS.md).

### Other platforms (coming soon)

- Distro packages (e.g. Fedora / RPM-style)
- macOS and Windows builds

### Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | bash
```

Works with **bash** and **zsh**. Auto-detects Linux x86_64 or arm64 (override with `--platform` / `XULU_PLATFORM`).

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
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | XULU_VERSION=v0.2.9 bash
```

### Verify a release asset

```bash
sha256sum -c xulu-linux-x86_64.sha256
chmod +x xulu-linux-x86_64
mkdir -p ~/.local/bin
mv xulu-linux-x86_64 ~/.local/bin/xulu
export PATH="$HOME/.local/bin:$PATH"
```

Use `~/.local/bin` so later `xulu update` can replace the binary without sudo.

## Inspect: file inspection

```bash
xulu inspect any-file.bin
xulu inspect results.parquet
xulu inspect export.csv --detailed
xulu inspect data.json --detailed -r json --pretty
xulu inspect big.jsonl --detailed -o report.txt
```

Useful flags: `--detailed`, `--depth`, `--max-keys`, `-o` / `--output`, `--full`, `--limit-stdout`, `--no-compact`, `-r` / `--report` (`txt` or `json`), `--pretty` (JSON reports only).

Full reference: [xulu inspect](https://docs.xulu.dev/commands/inspect/).

## Diff: file diffing

```bash
xulu diff yesterday.csv today.csv
xulu diff baseline.json result.json -o report.txt
xulu diff notes.txt notes.copy.txt -a myers
xulu diff a.csv b.csv -a key --key id
xulu diff a.parquet b.parquet -r json --pretty
```

Useful flags: `-a` / `--algorithm` (`positional`, `myers`, or `key`), `--key`, `--ignore-added`, `--atol`, `--rtol`, `--coerce-types`, `-o` / `--output`, `--full`, `--max-differences`, `--limit-stdout`, `-r` / `--report`, `--pretty`, `--color`.

Exit code is non-zero when differences are found (suitable for CI). Both sides must use the same format family.

### Using Xulu in CI

```bash
xulu diff expected.csv actual.csv
# exit 0 = equal; non-zero = differences or error
```

Full reference: [xulu diff](https://docs.xulu.dev/commands/diff/).

## Updating

```bash
xulu update          # prompt, then install latest
xulu update -y       # no prompt
xulu update --check  # report only
```

Updates download the matching Linux asset (x86_64 or arm64), verify the published SHA-256 checksum, then replace the binary in place.

## License and terms

- **[TERMS.md](./TERMS.md)**: Terms of Use (proprietary license, Swiss governing law, liability exclusions). **Read this before use.**
- **[LICENSE](./LICENSE)**: short proprietary notice pointing at TERMS.md

The CLI reads your files and writes reports; it does not modify the inputs as part of normal inspect/diff use.
