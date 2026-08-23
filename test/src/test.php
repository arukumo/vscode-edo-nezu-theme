// 変数シジル（$）、名前空間、アトリビュート、型宣言、Null合体演算子、PHPDoc、ヒアドキュメントの確認用
<?php

declare(strict_types=1);

namespace EdoNezu\Theme\Service;

use InvalidArgumentException;
use DateTimeImmutable;

/**
 * 伝統色カラーパレットマネージャー
 * @package EdoNezu
 */
#[Attribute]
final class TraditionalPalette
{
    private const THEME_NAME = "edo-nezu-theme";
    private readonly DateTimeImmutable $createdAt;

    public function __construct(
        private string $name,
        private ?string $hexCode = "#567a98",
        private bool $isHistorical = true
    ) {
        $this->createdAt = new DateTimeImmutable();
    }

    /**
     * RGB成分のパースと配列化
     *
     * @param string|null $hex
     * @throws InvalidArgumentException
     * @return array{r: int, g: int, b: int}
     */
    public function parseRgb(?string $hex = null): array
    {
        $targetHex = $hex ?? $this->hexCode;

        // 正規表現と文字列抽出テスト
        if (!preg_match('/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i', (string)$targetHex, $matches)) {
            throw new InvalidArgumentException("不正なHEXコードです: {$targetHex}");
        }

        return [
            'r' => (int)hexdec($matches[1]),
            'g' => (int)hexdec($matches[2]),
            'b' => (int)hexdec($matches[3]),
        ];
    }
}

// 実行・文字列補間・ヒアドキュメント
$palette = new TraditionalPalette(name: "舛花色", isHistorical: true);
$rgb = $palette->parseRgb();

$jsonOutput = <<<JSON
{
  "theme": "edo-nezu",
  "status": "ready",
  "rgb": [{$rgb['r']}, {$rgb['g']}, {$rgb['b']}]
}
JSON;

echo $jsonOutput;
