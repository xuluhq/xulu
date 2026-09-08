# Xulu

**Xulu Data Quality**: CLI-first data quality for structured data.

`xulu inspect`, `xulu diff`, `xulu validate`, and `xulu schema generate` run on your machine. No account required today. This repo ships **releases, install scripts, and docs links**; source stays private. Proprietary. See [TERMS.md](./TERMS.md) and [LICENSE](./LICENSE).

[xulu.dev](https://xulu.dev) · [docs.xulu.dev](https://docs.xulu.dev)

## What’s available today

| Command | Purpose |
|---------|---------|
| [`xulu inspect`](#inspect-file-inspection) | Basics for any file; schemas for CSV, JSON, JSONL, Parquet |
| [`xulu diff`](#diff-file-diffing) | Compare two files; reports and CI-friendly exit codes |
| [`xulu validate`](#validate-schema-checks) | Check a data file against a YAML or JSON schema |
| [`xulu schema generate`](#schema-generate) | Generate a starting YAML or JSON schema from a data file |
| `xulu update` | Update from GitHub Releases (checksum-verified) |
| `xulu changelog` | Show release notes |

### Formats

**Inspect (every readable file):** path, size, size on disk (when available), symlink, hidden, read-only, timestamps. Unknown content is labeled `unknown`; basics still print.

**Inspect (schemas with `--detailed`):** Parquet, JSON / JSONL, delimited text (CSV, TSV, SSV, PSV), plain text (line-oriented metadata).

**Diff:** Parquet (row-level), JSON / JSONL, delimited text, plain text.

**Validate:** Parquet, JSON / JSONL, delimited text against YAML or JSON schemas.

**Schema generation:** Parquet, JSON / JSONL, and delimited text to YAML or JSON schemas.

## Links

- [Site](https://xulu.dev): install and task pages
- [Docs](https://docs.xulu.dev): getting started, commands, examples, changelog
- [Getting started](https://docs.xulu.dev/getting-started/)
- [Releases](https://github.com/xuluhq/xulu/releases): binaries + SHA-256
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
| Validate CSV against a schema | [example](https://docs.xulu.dev/examples/csv-validate/) | [page](https://xulu.dev/csv-validation) |
| Validate JSON / JSONL | [example](https://docs.xulu.dev/examples/json-validate/) | [page](https://xulu.dev/json-validation) |
| Generate a CSV schema | [example](https://docs.xulu.dev/examples/csv-generate/) | [page](https://xulu.dev/csv-schema-generation) |
| Generate a Parquet schema | [example](https://docs.xulu.dev/examples/parquet-generate/) | [page](https://xulu.dev/parquet-schema-generation) |
| Validate data files | [command](https://docs.xulu.dev/commands/validate/) | [page](https://xulu.dev/file-validation) |

## Installation

Available for **Linux x86_64**, **Linux arm64**, **macOS Apple Silicon**, and **Windows x86_64**. By downloading or using the CLI, you agree to the [Terms of Use](./TERMS.md).

### Other platforms (coming soon)

- Distro packages (e.g. Fedora / RPM-style)
- macOS Intel
- Windows ARM64

### Quick install

Linux and macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | bash
```

Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/xuluhq/xulu/master/install.ps1 | iex
```

The shell installer works with **bash** and **zsh** and detects the supported Linux or macOS platform.

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
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | XULU_VERSION=v0.3.0 bash
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

xulu validate -d actual.csv -s schema.yaml
# exit 0 = passed; 1 = violations; 2 = error
```

Full reference: [xulu diff](https://docs.xulu.dev/commands/diff/).

## Validate: schema checks

```bash
xulu validate -d people.csv -s schema.yaml
xulu validate -d data.json -s schema.yaml
xulu validate -d table.parquet -s schema.yaml -o report.txt
xulu validate -d people.csv -s schema.yaml -r json --pretty
```

Useful flags: `-d` / `--data`, `-s` / `--schema`, `--data-format`, `-o` / `--output`, `-r` / `--report`, `--pretty`, `--max-violations`, `--full`, `--summary-only`, `--color`.

Full reference: [xulu validate](https://docs.xulu.dev/commands/validate/). Examples: [CSV validate](https://docs.xulu.dev/examples/csv-validate/), [JSON validate](https://docs.xulu.dev/examples/json-validate/).

## Schema: generate

```bash
xulu schema generate people.csv -o schema.yaml
xulu schema generate users.json -o schema.yaml --json-root users
xulu schema generate table.parquet -o schema.json --pretty
```

Review and edit the generated schema, then use it with `xulu validate`.

Full reference: [xulu schema generate](https://docs.xulu.dev/commands/schema/generate/). Examples: [CSV](https://docs.xulu.dev/examples/csv-generate/), [JSON](https://docs.xulu.dev/examples/json-generate/), [Parquet](https://docs.xulu.dev/examples/parquet-generate/).

## Updating

```bash
xulu update          # prompt, then install latest
xulu update -y       # no prompt
xulu update --check  # report only
```

Updates download the matching asset for the current supported platform, verify the published SHA-256 checksum, then replace the binary in place.

## License and terms

- **[TERMS.md](./TERMS.md)**: Terms of Use (proprietary license, Swiss governing law, liability exclusions). **Read this before use.**
- **[LICENSE](./LICENSE)**: short proprietary notice pointing at TERMS.md

The CLI reads your files and writes reports or schema files; it does not modify the inputs as part of normal inspect/diff/validate/schema-generation use.
