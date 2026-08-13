# Theme Color Reference

テーマJSONの色設定をCSVに変換し、Excelで配色や文法要素の分類を検討するためのメモです。

## 作業の流れ

1. `themes/` 配下のテーマJSONからCSVを作成する。
2. CSVをExcelで開き、色や文法要素の組み合わせを検討する。
3. CSVを更新し、確認用のJSONへ変換する。
4. 生成されたJSONと元のテーマJSONを差分比較する。
5. 問題がなければ、差分を確認したうえで `themes/` のテーマJSONへ手動で反映する。

## JSONからCSVへ

`[keyword]` にはテーマのキーワードを指定します。例: `dark`、`light`

```bash
./scripts/json2csv.sh [keyword]
```

例:

```bash
./scripts/json2csv.sh dark
```

入力:

```text
themes/edo-nezu-dark-color-theme.json
```

出力:

```text
scripts/edo-nezu-dark-theme.csv
```

## CSVから確認用JSONへ

編集したCSVから、`scripts/` 配下に確認用JSONを生成します。`themes/` 配下のファイルは直接上書きしません。

```bash
./scripts/csv2json.sh [keyword]
```

例:

```bash
./scripts/csv2json.sh dark
```

入力:

```text
scripts/edo-nezu-dark-theme.csv
```

出力:

```text
scripts/edo-nezu-dark-theme.json
```

生成JSONとテーマJSONを比較し、内容を確認します。

```bash
diff -u themes/edo-nezu-dark-color-theme.json scripts/edo-nezu-dark-theme.json
```

確認後、必要な差分だけを `themes/edo-nezu-dark-color-theme.json` に手動で反映します。

参考用の任意のテーマJSONを変換する場合は、`--ref` を使います。キーワードを省略すると、入力ファイル名から出力CSVのキーワードを推測します。

```bash
./scripts/json2csv.sh --ref /path/to/gruvbox-color-theme.json
```

出力名を明示する場合:

```bash
./scripts/json2csv.sh --ref /path/to/theme.json reference
```

### ライセンスについて

参考テーマをCSV化して配色や文法要素の分類を調べる場合でも、元テーマのライセンスを確認します。
定義・画像・アイコンなどをこのプロジェクトへ取り込んで配布する場合は、改変・再配布の条件、著作権表示、ライセンス文の同梱条件に従います。
参考テーマの名前やファイルをそのまま配布物へ含めないように注意します。

使い方は、`-h` または `--help` でも確認できます。

```bash
./scripts/json2csv.sh --help
```

## Excelで編集するときの注意

- CSVは参考・検討用として扱う。
- `csv2json.sh` で生成するJSONは確認用として扱う。
- CSVのヘッダーは変更しない。
- `type` 列は変更しない。
- `scope` は1つにつき1行で保持する。
- 色の値はVS Codeで使用できる形式で入力する。
- 他人の参考テーマは `json2csv.sh --ref` でCSV化し、JSONへ戻さない。
