"""Python構文解析検証スクリプト.

デコレータ（@）、型ヒント（Type Hints）、f-strings、特殊メソッド（__init__, __repr__）、内包表記、例外処理、docstring、データクラスなど
"""

from __future__ import annotations

import re
import sys
from dataclasses import dataclass, field
from enum import Enum, auto
from typing import Final, Iterator, Optional, TypeVar

THEME_VERSION: Final[str] = "1.0.0"
T = TypeVar("T")


class ColorFamily(Enum):
    """色系統の分類."""

    WHITE_BASE = auto()
    BLUE_NEZU = auto()
    TEA_BROWN = auto()
    CLAY_GREEN = auto()


def log_execution(func):
    """デコレータ構文テスト."""

    def wrapper(*args, **kwargs):
        # 組み込み関数・文字列フォーマット
        print(f"[DEBUG] Executing: {func.__name__}")
        return func(*args, **kwargs)

    return wrapper


@dataclass(frozen=True)
class TraditionalColor:
    """伝統色データクラス."""

    color_id: int
    name: str
    hex_code: str
    family: ColorFamily
    is_traditional: bool = True
    metadata: dict[str, str] = field(default_factory=dict)

    def __post_init__(self) -> None:
        """HEXコードのバリデーション."""
        if not re.match(r"^#[0-9a-fA-F]{6}$", self.hex_code):
            raise ValueError(f"無効なHEXコードです: {self.hex_code}")

    @property
    def rgb(self) -> tuple[int, int, int]:
        """HEXからRGBタプルへの変換."""
        hex_clean = self.hex_code.lstrip("#")
        return tuple(int(hex_clean[i : i + 2], 16) for i in (0, 2, 4))  # type: ignore

    @log_execution
    def calculate_luminance(self) -> float:
        """相対輝度（Relative Luminance）の計算."""
        r, g, b = [val / 255.0 for val in self.rgb]
        return 0.2126 * r + 0.7152 * g + 0.0722 * b


class ThemeCollection:
    """パレットコレクション管理."""

    def __init__(self, theme_name: str = "edo-nezu-theme") -> None:
        self.theme_name = theme_name
        self._colors: list[TraditionalColor] = []

    def add(self, color: TraditionalColor) -> None:
        self._colors.append(color)

    def __iter__(self) -> Iterator[TraditionalColor]:
        return iter(self._colors)

    def __len__(self) -> int:
        return len(self._colors)


def main() -> None:
    collection = ThemeCollection()

    # サンプルデータ登録
    collection.add(
        TraditionalColor(1, "白鼠", "#dcdddd", ColorFamily.WHITE_BASE)
    )
    collection.add(
        TraditionalColor(2, "舛花色", "#567a98", ColorFamily.BLUE_NEZU)
    )
    collection.add(
        TraditionalColor(3, "江戸茶", "#cd8c5c", ColorFamily.TEA_BROWN)
    )
    collection.add(
        TraditionalColor(4, "老竹色", "#6a8372", ColorFamily.CLAY_GREEN)
    )

    # リスト内包表記と辞書内包表記
    luminance_map = {
        color.name: f"{color.calculate_luminance():.3f}"
        for color in collection
        if color.is_traditional
    }

    try:
        for name, lum in luminance_map.items():
            print(f"色彩名: {name:<6} | 相対輝度: {lum}")
    except (KeyError, TypeError) as exc:
        print(f"例外キャッチ: {exc}", file=sys.stderr)


if __name__ == "__main__":
    main()
