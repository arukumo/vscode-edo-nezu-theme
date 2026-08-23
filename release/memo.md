# メモ

## コマンドメモ

```bash
# パッケージ化ツールをインストール（初回のみ）
npm install -g @vscode/vsce

# 出力先ディレクトリを作成（初回のみ）
mkdir -p release

v0.0.1でビルド
vsce package -o release/v0.0.1.vsix

# ローカルにインストール
code --install-extension release/v0.0.1.vsix

# リスト一覧
code --list-extensions | grep -i edo

# アンインストール
code --uninstall-extension arukumo.edo-nezu-theme
```
