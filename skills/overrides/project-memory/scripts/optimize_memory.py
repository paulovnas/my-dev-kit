#!/usr/bin/env python3
from __future__ import annotations

import argparse
import shutil
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path


TARGET_FILES = ("product.md", "structure.md", "tech.md")


@dataclass
class FileStats:
    file: str
    before_lines: int
    after_lines: int
    before_chars: int
    after_chars: int
    changed: bool
    removed_blank_lines: int
    removed_consecutive_duplicates: int
    trimmed_trailing_spaces: int


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Perform safe structural optimization for .memory files "
            "(normalize whitespace + remove consecutive duplicate lines)."
        )
    )
    parser.add_argument("--project-root", default=".", help="Project root path.")
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Analyze and report changes without writing files.",
    )
    parser.add_argument(
        "--skip-backup",
        action="store_true",
        help="Skip backup creation before changes.",
    )
    return parser.parse_args()


def normalize_text(text: str) -> tuple[str, int, int, int]:
    lines = text.splitlines()
    normalized: list[str] = []

    removed_blank_lines = 0
    removed_consecutive_duplicates = 0
    trimmed_trailing_spaces = 0
    previous_nonempty: str | None = None
    previous_line: str | None = None

    for raw in lines:
        stripped_right = raw.rstrip()
        if stripped_right != raw:
            trimmed_trailing_spaces += 1
        line = stripped_right

        if line == "" and previous_line == "":
            removed_blank_lines += 1
            continue

        # Safe dedupe: remove only exact consecutive duplicates.
        if line != "" and previous_nonempty == line:
            removed_consecutive_duplicates += 1
            previous_line = line
            continue

        normalized.append(line)
        previous_line = line
        if line != "":
            previous_nonempty = line

    normalized_text = "\n".join(normalized).rstrip() + "\n"
    return (
        normalized_text,
        removed_blank_lines,
        removed_consecutive_duplicates,
        trimmed_trailing_spaces,
    )


def backup_files(memory_dir: Path, files: list[Path]) -> Path:
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    archive_dir = memory_dir / "archive" / f"compaction-{timestamp}"
    archive_dir.mkdir(parents=True, exist_ok=True)

    for file_path in files:
        if file_path.exists():
            shutil.copy2(file_path, archive_dir / file_path.name)

    return archive_dir


def main() -> int:
    args = parse_args()
    project_root = Path(args.project_root).resolve()
    memory_dir = project_root / ".memory"

    if not memory_dir.exists():
        print(f"[error] .memory nao encontrado em: {memory_dir}")
        print("Execute primeiro o init_memory.py para criar baseline.")
        return 1

    target_paths = [memory_dir / name for name in TARGET_FILES]
    existing_paths = [p for p in target_paths if p.exists()]

    if not existing_paths:
        print("[error] Nenhum arquivo alvo encontrado em .memory:")
        for path in target_paths:
            print(f"  - {path.name}")
        return 1

    archive_dir: Path | None = None
    if not args.dry_run and not args.skip_backup:
        archive_dir = backup_files(memory_dir, existing_paths)

    stats: list[FileStats] = []
    changed_files = 0

    for path in target_paths:
        if not path.exists():
            continue

        original = path.read_text(encoding="utf-8")
        normalized, removed_blanks, removed_dups, trimmed_spaces = normalize_text(original)

        changed = normalized != original
        if changed and not args.dry_run:
            path.write_text(normalized, encoding="utf-8")
            changed_files += 1

        stat = FileStats(
            file=path.name,
            before_lines=len(original.splitlines()),
            after_lines=len(normalized.splitlines()),
            before_chars=len(original),
            after_chars=len(normalized),
            changed=changed,
            removed_blank_lines=removed_blanks,
            removed_consecutive_duplicates=removed_dups,
            trimmed_trailing_spaces=trimmed_spaces,
        )
        stats.append(stat)

    print("Memory optimization report")
    print("--------------------------")
    print(f"Project root: {project_root}")
    print(f"Dry run: {'yes' if args.dry_run else 'no'}")
    if archive_dir is not None:
        print(f"Backup: {archive_dir}")
    elif args.dry_run:
        print("Backup: skipped (dry-run)")
    else:
        print("Backup: skipped (--skip-backup)")
    print("")

    for s in stats:
        status = "changed" if s.changed else "no-change"
        print(f"[{status}] {s.file}")
        print(f"  lines: {s.before_lines} -> {s.after_lines}")
        print(f"  chars: {s.before_chars} -> {s.after_chars}")
        print(f"  removed blank lines: {s.removed_blank_lines}")
        print(f"  removed consecutive duplicates: {s.removed_consecutive_duplicates}")
        print(f"  trimmed trailing spaces: {s.trimmed_trailing_spaces}")

    if not args.dry_run:
        print("")
        print(f"Files updated: {changed_files}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
