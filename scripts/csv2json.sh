#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
	cat <<'USAGE'
Usage: csv2json.sh <color-theme-keyword>

Convert an edited theme CSV file to a JSON file for review.

Input:
  scripts/edo-nezu-<keyword>-theme.csv

Output:
    scripts/edo-nezu-<keyword>-theme.json

Example:
  ./scripts/csv2json.sh dark
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
	usage
	exit 0
fi

if [[ $# -ne 1 ]]; then
	usage >&2
	exit 1
fi

KEYWORD="$1"
if [[ ! "$KEYWORD" =~ ^[A-Za-z0-9][A-Za-z0-9_-]*$ ]]; then
	echo "Invalid color-theme keyword: $KEYWORD" >&2
	exit 1
fi

CSV_FILE="$SCRIPT_DIR/edo-nezu-${KEYWORD}-theme.csv"
JSON_FILE="$SCRIPT_DIR/edo-nezu-${KEYWORD}-theme.json"

if [[ ! -f "$CSV_FILE" ]]; then
	echo "No such color theme CSV: $CSV_FILE" >&2
	exit 1
fi

python3 - "$CSV_FILE" "$JSON_FILE" <<'PY'
import csv
import json
import sys

csv_file, json_file = sys.argv[1:]
required_columns = {
    "type",
    "name",
    "scope",
    "settings.fontStyle",
    "settings.foreground",
}

colors = {}
token_colors = []
theme_name = "Edo Nezu Theme"

with open(csv_file, newline="", encoding="utf-8") as input_file:
    reader = csv.DictReader(input_file)
    if reader.fieldnames is None or not required_columns.issubset(reader.fieldnames):
        raise SystemExit("CSV header must contain the expected theme columns")

    for row in reader:
        row_type = row["type"]

        if row_type == "theme":
            if row["name"]:
                theme_name = row["name"]
            continue

        settings = {}
        if row["settings.fontStyle"]:
            settings["fontStyle"] = row["settings.fontStyle"]
        if row["settings.foreground"]:
            settings["foreground"] = row["settings.foreground"]

        if row_type == "color":
            colors[row["scope"]] = row["settings.foreground"]
        elif row_type == "tokenColor":
            token_colors.append({
                "name": row["name"],
                "scope": row["scope"].splitlines(),
                "settings": settings,
            })
        else:
            raise SystemExit(f"Unknown row type: {row_type}")

theme = {
    "name": theme_name,
    "colors": colors,
    "tokenColors": token_colors,
}

with open(json_file, "w", encoding="utf-8") as output_file:
    json.dump(theme, output_file, ensure_ascii=False, indent=2)
    output_file.write("\n")
PY

echo "Generated: $JSON_FILE"
