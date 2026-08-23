package com.edonezu.theme.test

import kotlinx.coroutines.flow.asFlow
import kotlinx.coroutines.flow.filter
import kotlinx.coroutines.flow.map

/**
 * 江戸伝統色テーマ - Kotlin構文解析検証
 * データクラス、拡張関数、Smart Cast、Coroutines/Flow、Null Safety、ラムダ式の確認用
 */
enum class ColorCategory(val label: String) {
    WHITE("白灰系"),
    BLUE_NEZU("青鼠系"),
    TEA_BROWN("茶系")
}

data class TraditionalColor(
    val id: Int,
    val name: String,
    val hexCode: String,
    val category: ColorCategory = ColorCategory.BLUE_NEZU
) {
    val isValidHex: Boolean
        get() = hexCode.matches(Regex("^#[0-9a-fA-F]{6}$"))
}

// 拡張関数
fun TraditionalColor.toFormattedLog(): String =
    "[$id] $name ($hexCode) - Category: ${category.label}"

suspend fun main() {
    val palette = listOf(
        TraditionalColor(1, "白鼠", "#dcdddd", ColorCategory.WHITE),
        TraditionalColor(2, "舛花色", "#567a98", ColorCategory.BLUE_NEZU),
        TraditionalColor(3, "江戸茶", "#cd8c5c", ColorCategory.TEA_BROWN)
    )

    palette.asFlow()
        .filter { it.isValidHex }
        .map { it.toFormattedLog() }
        .collect { println(it) }
}
