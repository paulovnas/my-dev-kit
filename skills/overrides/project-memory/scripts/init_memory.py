#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path


FILES = {
    "product.md": "product-template.md",
    "structure.md": "structure-template.md",
    "tech.md": "tech-template.md",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Create or update .memory baseline files (product.md, structure.md, tech.md)."
    )
    parser.add_argument("--project-root", default=".", help="Project root path.")
    parser.add_argument(
        "--project-name",
        default=None,
        help="Optional project name for template replacement.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite files if they already exist.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    project_root = Path(args.project_root).resolve()
    project_name = args.project_name or project_root.name

    skill_root = Path(__file__).resolve().parent.parent
    templates_root = skill_root / "references"

    memory_dir = project_root / ".memory"
    memory_dir.mkdir(parents=True, exist_ok=True)

    created = 0
    skipped = 0

    for output_name, template_name in FILES.items():
        template_path = templates_root / template_name
        output_path = memory_dir / output_name

        if not template_path.exists():
            raise FileNotFoundError(f"Template not found: {template_path}")

        if output_path.exists() and not args.force:
            skipped += 1
            print(f"[skip] {output_path}")
            continue

        content = template_path.read_text(encoding="utf-8")
        content = content.replace("{{PROJECT_NAME}}", project_name)
        output_path.write_text(content, encoding="utf-8")
        created += 1
        print(f"[ok]   {output_path}")

    print("")
    print(f"Memory folder: {memory_dir}")
    print(f"Created/updated: {created}")
    print(f"Skipped: {skipped}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
