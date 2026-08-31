# Xulu

**Local CLI for file inspection, structural data diff, and (soon) file validation.**

**Website:** [Xulu — local CLI for file inspection and structural data diff](https://xulu.dev)

Xulu helps you understand and compare files **on your machine**. **`xulu inspect`** reports filesystem basics for **any readable file** (size, symlink, read-only, hidden, timestamps) and adds format detection plus schemas for CSV, JSON, JSONL, Parquet, and plain text. **`xulu diff`** compares those structured formats with CI-friendly exit codes. No account required for inspect and diff today.

This repository holds **releases, the install script, and documentation links**. Source code is developed privately. The Software is **proprietary** — see [TERMS.md](./TERMS.md) and [LICENSE](./LICENSE).

## What’s available today

| Command | Purpose |
|---------|---------|
| [`xulu inspect`](#inspect--file-inspection) | **File inspection** — basics for any file; format detection, schemas, and structural summaries for known types |
| [`xulu diff`](#diff--file-diffing) | **File diffing** — compare two files (CSV, JSON, Parquet, text) with clear reports |
| `xulu update` | Update the CLI from GitHub Releases (checksum-verified) |
| `xulu changelog` | Show release notes |

**Coming soon:** **file validation** (`validate` and related tooling), more CLI capabilities, a platform for managing reports, and scheduled checks — documented as they ship. Inspect and diff remain free to use today; future editions will be described before anything moves behind a paid tier.

### Formats

**Inspect — every readable file**

- Path, size, size on disk (when available), symlink, hidden, read-only, timestamps
- Unrecognized content is labeled `unknown`; those basics still print

**Inspect — format detection and schemas** (`--detailed` for rich structure)

- **Parquet** — schema and layout
- **JSON** / **JSONL** (NDJSON) — structure summaries
- **Delimited text** — CSV, TSV, SSV (semicolon), PSV (pipe), and related layouts
- **Plain text** — line-oriented metadata

**Diff — structured formats**

- Parquet (row-level), JSON / JSONL, delimited text, plain text

## Links

- [Xulu marketing site](https://xulu.dev) — product overview, install, and use-case pages (Parquet schema, CSV diff, JSON diff)
- [Xulu CLI documentation](https://docs.xulu.dev) — getting started, commands, guides, changelog
- [Getting started with the Xulu CLI](https://docs.xulu.dev/getting-started/) — install and first inspect/diff
- [GitHub Releases](https://github.com/xuluhq/xulu/releases) — Linux x86_64 binaries + SHA-256 checksums
- [Terms of Use](./TERMS.md) — license and liability for the CLI binary
- Assistant-oriented map: [Xulu docs llms.txt](https://docs.xulu.dev/llms.txt)

### Common tasks

| Task | Page |
|------|------|
| Parquet schema CLI | [Xulu Parquet schema guide](https://docs.xulu.dev/guides/parquet-schema/) · [marketing page](https://xulu.dev/parquet-schema) |
| CSV diff CLI | [Xulu CSV diff guide](https://docs.xulu.dev/guides/csv-diff/) · [marketing page](https://xulu.dev/csv-diff) |
| JSON diff CLI | [Xulu JSON diff guide](https://docs.xulu.dev/guides/json-diff/) · [marketing page](https://xulu.dev/json-diff) |
| File inspection | [Xulu file inspection guide](https://docs.xulu.dev/guides/file-inspection/) · [marketing page](https://xulu.dev/file-inspection) |
| File diff | [Xulu file diff guide](https://docs.xulu.dev/guides/file-diff/) · [marketing page](https://xulu.dev/file-diff) |
| File validation (soon) | [Xulu file validation guide](https://docs.xulu.dev/guides/file-validation/) · [marketing page](https://xulu.dev/file-validation) |

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

**Any readable file** gets source/storage basics. Known structured formats also get detection and optional schemas:

```bash
xulu inspect any-file.bin
xulu inspect results.parquet
xulu inspect export.csv --detailed
xulu inspect data.json --detailed -r json --pretty
xulu inspect big.jsonl --detailed -o report.txt
```

Useful flags: `--detailed`, `--depth`, `--max-keys`, `-o` / `--output`, `--full`, `--limit-stdout`, `--no-compact`, `-r` / `--report` (`txt` or `json`), `--pretty` (JSON reports only).

Full reference: [xulu inspect command documentation](https://docs.xulu.dev/commands/inspect/).

## Diff — file diffing

Compare two datasets:

```bash
xulu diff yesterday.csv today.csv
xulu diff baseline.json result.json -o report.txt
xulu diff notes.txt notes.copy.txt -A myers
xulu diff a.parquet b.parquet -r json --pretty
```

Useful flags: `-A` / `--algorithm` (`positional` or `myers`), `-o` / `--output`, `--full`, `--max-differences`, `--limit-stdout`, `-r` / `--report`, `--pretty` (JSON reports only), `--color`.

Exit code is non-zero when differences are found — suitable for CI.

Full reference: [xulu diff command documentation](https://docs.xulu.dev/commands/diff/).

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

xulu cli · file inspection · inspect any file · file size metadata · file diffing · structural data diff · parquet schema cli · csv diff cli · json diff cli · parquet diff · structured data cli · local data tooling · data file comparison
