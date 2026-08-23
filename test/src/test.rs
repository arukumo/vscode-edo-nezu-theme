//! Rust: ライフタイム、トレイト、Enum（Option/Result）、パターンマッチング、マクロ、構造体（struct）の確認用

use std::collections::HashMap;
use std::fmt::{self, Display, Formatter};

/// 色系統の分類列挙型
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ColorFamily {
    White,
    BlueNezu,
    TeaBrown,
}

/// 伝統色トークン構造体
pub struct TraditionalColor<'a> {
    pub name: &'a str,
    pub hex: &'a str,
    pub family: ColorFamily,
}

pub trait LuminanceCalculable {
    fn calculate_luminance(&self) -> Result<f64, &'static str>;
}

impl<'a> LuminanceCalculable for TraditionalColor<'a> {
    fn calculate_luminance(&self) -> Result<f64, &'static str> {
        if !self.hex.starts_with('#') || self.hex.len() != 7 {
            return Err("無効なHEXコードです");
        }

        let r = u8::from_str_radix(&self.hex[1..3], 16).map_err(|_| "パースエラー")?;
        let g = u8::from_str_radix(&self.hex[3..5], 16).map_err(|_| "パースエラー")?;
        let b = u8::from_str_radix(&self.hex[5..7], 16).map_err(|_| "パースエラー")?;

        Ok(0.2126 * (r as f64) + 0.7152 * (g as f64) + 0.0722 * (b as f64))
    }
}

impl<'a> Display for TraditionalColor<'a> {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "色名: {} ({})", self.name, self.hex)
    }
}

fn main() {
    let colors = vec![
        TraditionalColor { name: "白鼠", hex: "#dcdddd", family: ColorFamily::White },
        TraditionalColor { name: "舛花色", hex: "#567a98", family: ColorFamily::BlueNezu },
        TraditionalColor { name: "江戸茶", hex: "#cd8c5c", family: ColorFamily::TeaBrown },
    ];

    for color in &colors {
        match color.calculate_luminance() {
            Ok(lum) => println!("{}: 輝度値 = {:.2}", color, lum),
            Err(e) => eprintln!("エラー [{}]: {}", color.name, e),
        }
    }
}
