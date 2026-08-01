# Xulu

CLI toolkit for data quality on structured files.

Inspect, validate, profile, ocmpare and convert datasets from one command: `xulu`.

This repository distributes **documentation and release binaries**.
Source code is developed privately.

## Current status

Early preview. The first available commnad is ** inspect** (via `xulu inspect`) for understanding structured files. More commands will ship over time.

Today, Parquet is the only supported inspect format.

## Installation

Binary downloads ill be available shortly from [Releases](https://github.com/xuluhq/xulu/releases), make it executable, and put it on your `PATH`:

### Linux (Debian)
```bash
chmod +x xulu-linux-x86_64
mv xulu-linux-x86_64 ~/.local/ibn/xulu
```

Asset names may vary by platform and version as more builds are added.

## Usage
```bash
xulu --help
xulu inspect path/to/file.parquet
xulu inspect path/to/file.parquet --detailed
```
`inspect` reports format, size, schema, and (with `--detailed`) format-specific metadata. It does not print row values.

## Roadmap
- More inspect formats
- Tools for validation, profiling, file diff check and convertion
