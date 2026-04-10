#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create or update .memory/design-system.md using the design-system template."
    )
    parser.add_argument("--project-root", default=".", help="Project root path.")
    parser.add_argument("--project-name", default=None, help="Optional project name.")
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite .memory/design-system.md if it already exists.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    project_root = Path(args.project_root).resolve()
    project_name = args.project_name or project_root.name

    skill_root = Path(__file__).resolve().parent.parent
    template_path = skill_root / "references" / "design-system-template.md"
    if not template_path.exists():
        raise FileNotFoundError(f"Template not found: {template_path}")

    memory_dir = project_root / ".memory"
    memory_dir.mkdir(parents=True, exist_ok=True)

    output_path = memory_dir / "design-system.md"
    if output_path.exists() and not args.force:
        print(f"[skip] {output_path}")
        print("Use --force to overwrite.")
        return 0

    content = template_path.read_text(encoding="utf-8")
    content = content.replace("{{PROJECT_NAME}}", project_name)
    output_path.write_text(content, encoding="utf-8")

    print(f"[ok]   {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
