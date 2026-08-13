#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
	cat <<'USAGE'
Usage:
	json2csv.sh <color-theme-keyword>
	json2csv.sh --ref <theme-json-file> [color-theme-keyword]

Convert a theme JSON file to a CSV file.

Input:
  themes/edo-nezu-<keyword>-color-theme.json
	or a JSON file specified with --ref

Output:
  scripts/edo-nezu-<keyword>-theme.csv

Example:
  ./scripts/json2csv.sh dark
	./scripts/json2csv.sh --ref /path/to/gruvbox-color-theme.json
	./scripts/json2csv.sh --ref /path/to/theme.json reference
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
	usage
	exit 0
fi

if [[ $# -lt 1 || $# -gt 3 ]]; then
	usage >&2
	exit 1
fi

if [[ "$1" == "--ref" ]]; then
	if [[ $# -lt 2 ]]; then
		echo "Missing reference theme JSON file" >&2
		usage >&2
		exit 1
	fi

	JSON_FILE="$2"
	if [[ $# -eq 3 ]]; then
		KEYWORD="$3"
	else
		REFERENCE_NAME="${JSON_FILE##*/}"
		REFERENCE_NAME="${REFERENCE_NAME%.json}"
		REFERENCE_NAME="${REFERENCE_NAME%-color-theme}"
		REFERENCE_NAME="${REFERENCE_NAME%-theme}"
		KEYWORD="${REFERENCE_NAME#edo-nezu-}"
	fi
else
	if [[ $# -ne 1 ]]; then
		usage >&2
		exit 1
	fi

	KEYWORD="$1"
	JSON_FILE="$SCRIPT_DIR/../themes/edo-nezu-${KEYWORD}-color-theme.json"
fi

if [[ ! "$KEYWORD" =~ ^[A-Za-z0-9][A-Za-z0-9_-]*$ ]]; then
	echo "Invalid color-theme keyword: $KEYWORD" >&2
	exit 1
fi

CSV_FILE="$SCRIPT_DIR/edo-nezu-${KEYWORD}-theme.csv"

if [[ ! -f "$JSON_FILE" ]]; then
	echo "No such color theme: $JSON_FILE" >&2
	exit 1
fi

jq -r '
	(["type", "name", "scope", "settings.fontStyle", "settings.foreground"] | @csv),
	(["theme", .name, "", "", ""] | @csv),
	(.colors | to_entries[] | ["color", "", .key, "", .value] | @csv),
	(.tokenColors[] | ["tokenColor", .name, (.scope | join("\n")), (.settings.fontStyle // ""), (.settings.foreground // "")] | @csv)
' "$JSON_FILE" > "$CSV_FILE"
