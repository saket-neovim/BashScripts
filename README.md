# Bash Utilities and Linux Administration Exercises

Small Bash scripts exploring filesystem checks, backups, logs, services, argument parsing, and CSV inventory filtering. This is a learning collection, with a few reusable command-line examples rather than a production operations toolkit.

## Start here

| File | Behavior |
| --- | --- |
| [diskcheck.sh](diskcheck.sh) | Check disk usage for a path against a threshold; `-v` adds context |
| [backup.sh](backup.sh) | Copy a single file into an existing directory, optionally compress it; `-n` previews the operation |
| [lab13](lab13) and [inventory.csv](inventory.csv) | Filter demonstration inventory rows by environment |
| `lab01`–`lab17` | Numbered practice scripts covering host facts, files, logs, services, and configuration |
| [config](config) | Small sample configuration for text-processing exercises |

## Requirements and examples

Use Bash and standard Linux tools such as `df`, `awk`, `find`, `tar`, and `gzip`. Some labs also require `systemctl`, `ss`, or GNU command behavior, so macOS is not a substitute for the Linux exercises.

From the repository root:

```bash
bash -n diskcheck.sh backup.sh
bash diskcheck.sh -p / -t 80 -v
bash lab13 staging
mkdir -p /tmp/bash-lab-backups
bash backup.sh -s ./config -d /tmp/bash-lab-backups -n
```

The backup script accepts one source **file**, not a directory. Remove `-n` only when you intend to create the backup.

## Review before running

`bash -n` checks shell syntax; it does not prove correct runtime behavior. Read each exercise before execution. In particular, `lab04` can archive and delete logs, `lab10` copies a file, and `lab11` modifies a file after confirmation. Test those with disposable data.

`lab16` expects an untracked `prod.env` with `APP_NAME`, `LOG_DIR`, and `BACKUP_DIR`. Shell sourcing executes code: use a local file you trust. Inventory addresses are synthetic examples, not real hosts.

## Limitations and cleanup

Argument validation, quoting, error propagation, and platform assumptions vary across the practice scripts. These scripts do not establish production backup/recovery guarantees. Remove only the temporary files or backups created during your own test after checking their contents. Keep environment files, real inventory, credentials, logs, and generated archives out of Git.
