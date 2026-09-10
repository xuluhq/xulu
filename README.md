# Xulu

<p align="center">
  <img src="logo-mark.svg" width="72" alt="Xulu" />
</p>

<p align="center">
  <strong>Local CLI for structured data quality</strong><br />
  Inspect, compare, and validate CSV, JSON, JSONL, and Parquet on your machine.
</p>

<p align="center">
  <a href="https://xulu.dev">Website</a> ·
  <a href="https://docs.xulu.dev">Docs</a> ·
  <a href="https://github.com/xuluhq/xulu/releases">Releases</a>
</p>

Xulu helps when you have data files on disk and need a clear answer: what is in this file, what changed between two exports, or does this file match a schema. It runs locally. Nothing is uploaded. No account required today.

This GitHub repository distributes the CLI (binaries and install scripts). The product site and docs live on [xulu.dev](https://xulu.dev) and [docs.xulu.dev](https://docs.xulu.dev). Source code is not published. Use is governed by [TERMS.md](./TERMS.md).

## Install

Supported today: **Linux x86_64**, **Linux arm64**, **macOS Apple Silicon**, **Windows x86_64**.

By downloading or using the CLI, you agree to the [Terms of Use](./TERMS.md).

**Linux / macOS**

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | bash
```

**Windows (PowerShell)**

```powershell
irm https://raw.githubusercontent.com/xuluhq/xulu/master/install.ps1 | iex
```

The installer puts the binary in `~/.local/bin/xulu` and checks the published SHA-256 when it can. Open a new terminal afterward, or run `source ~/.local/share/xulu/env.sh`, then:

```bash
xulu --version
```

To pin a version:

```bash
curl -fsSL https://raw.githubusercontent.com/xuluhq/xulu/master/install.sh | XULU_VERSION=v0.3.1 bash
```

Or download assets from [Releases](https://github.com/xuluhq/xulu/releases). Later, `xulu update` can refresh the install in place.

## Try it

```bash
# What is this file?
xulu inspect results.parquet --detailed

# What changed between two CSVs (join on id when row order differs)?
xulu diff yesterday.csv today.csv --algorithm key --key id

# Does this CSV match the schema?
xulu validate -d people.csv -s schema.yaml

# Start a schema from sample data, then edit and validate
xulu schema generate people.csv -o schema.yaml
```

`xulu diff` exits non-zero when files differ. `xulu validate` exits `0` on pass, `1` on violations, `2` on error. That makes both usable in CI.

## Walkthroughs

Longer guides with sample files and captured terminal output:

- [Compare two CSV files](https://xulu.dev/how-to-compare-csv-files)
- [Inspect a Parquet file](https://xulu.dev/how-to-inspect-a-parquet-file)
- [Validate a CSV file](https://xulu.dev/how-to-validate-a-csv-file)

Also: [Getting started](https://docs.xulu.dev/getting-started/) · [Examples overview](https://docs.xulu.dev/examples/)

## Commands

| Command | What it does |
|---------|----------------|
| [`xulu inspect`](https://docs.xulu.dev/commands/inspect/) | File basics for any path; add `--detailed` for schemas on supported formats |
| [`xulu diff`](https://docs.xulu.dev/commands/diff/) | Compare two files (positional, Myers, or key join) |
| [`xulu validate`](https://docs.xulu.dev/commands/validate/) | Check a file against a YAML or JSON schema |
| [`xulu schema generate`](https://docs.xulu.dev/commands/schema/generate/) | Infer a starting schema from a data file |
| `xulu update` | Install the latest release |
| `xulu changelog` | Show release notes |

Full flag reference: [docs.xulu.dev/commands](https://docs.xulu.dev/commands/).

## License

Xulu is proprietary software. See [TERMS.md](./TERMS.md) and [LICENSE](./LICENSE). Website legal pages: [terms](https://xulu.dev/legal/terms), [privacy](https://xulu.dev/legal/privacy), [imprint](https://xulu.dev/legal/imprint).

Questions: [support@xulu.dev](mailto:support@xulu.dev).
