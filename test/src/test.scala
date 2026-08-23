package com.edonezu.theme.test

/**
 * 江戸伝統色テーマ - Scala 3 構文解析検証
 * Case Class、Pattern Matching、Trait、Implicit/Given、高階関数の確認用
 */
enum ColorCategory(val description: String):
  case WhiteBase extends ColorCategory("白灰系")
  case BlueNezu  extends ColorCategory("青鼠系")
  case TeaBrown  extends ColorCategory("茶系")

case class TraditionalColor(
    id: Int,
    name: String,
    hex: String,
    category: ColorCategory
):
  def luminance: Option[Double] =
    if hex.startsWith("#") && hex.length == 7 then
      val r = Integer.parseInt(hex.substring(1, 3), 16) / 255.0
      val g = Integer.parseInt(hex.substring(3, 5), 16) / 255.0
      val b = Integer.parseInt(hex.substring(5, 7), 16) / 255.0
      Some(0.2126 * r + 0.7152 * g + 0.0722 * b)
    else None

object TestTheme:
  def main(args: Array[String]): Unit =
    val colors = List(
      TraditionalColor(1, "白鼠", "#dcdddd", ColorCategory.WhiteBase),
      TraditionalColor(2, "舛花色", "#567a98", ColorCategory.BlueNezu),
      TraditionalColor(3, "江戸茶", "#cd8c5c", ColorCategory.TeaBrown)
    )

    colors.foreach {
      case color @ TraditionalColor(id, name, hex, cat) =>
        val lumStr = color.luminance.map(l => f"$l%.2f").getOrElse("N/A")
        println(s"[$id] $name ($hex) - ${cat.description} | 輝度: $lumStr")
    }
