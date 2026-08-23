#!/bin/bash
set -e

# 出力先ディレクトリの作成
mkdir -p release

# package.json から拡張機能情報を自動取得
PUBLISHER=$(grep '"publisher"' package.json | head -1 | awk -F: '{ print $2 }' | sed 's/[", ]//g')
EXTENSION=$(grep '"name"' package.json | head -1 | awk -F: '{ print $2 }' | sed 's/[", ]//g')
VERSION=$(grep '"version"' package.json | head -1 | awk -F: '{ print $2 }' | sed 's/[", ]//g')
EXT_ID="${PUBLISHER}.${EXTENSION}"
VSIX_FILE="release/${EXTENSION}-${VERSION}.vsix"

echo "=== Building ${VSIX_FILE} ==="
npx @vscode/vsce package -o "${VSIX_FILE}"

echo "=== Uninstalling existing extension: ${EXT_ID} ==="
# アンインストール（未インストールの初回実行時でも止まらないよう || true を付与）
code --uninstall-extension "${EXT_ID}" || true

echo "=== Installing fresh VSIX ==="
code --install-extension "${VSIX_FILE}" --force

echo "=== Done! Reload VS Code Window (Developer: Reload Window) ==="
