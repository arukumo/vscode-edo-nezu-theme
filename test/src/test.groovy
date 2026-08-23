package com.edonezu.theme.test

import groovy.transform.Canonical

/**
 * 江戸伝統色テーマ - Groovy / Gradle DSL 構文解析検証
 * GString（${}）、動的型付け（def）、クロージャ、Mapリテラル、Safe Navigation（?.）の確認用
 */
@Canonical
class ColorToken {
    Integer id
    String name
    String hex
    boolean active = true
}

class ThemeManager {
    static void main(String[] args) {
        def colors = [
            new ColorToken(id: 1, name: '白鼠', hex: '#dcdddd'),
            new ColorToken(id: 2, name: '舛花色', hex: '#567a98'),
            new ColorToken(id: 3, name: '江戸茶', hex: '#cd8c5c', active: false)
        ]

        // クロージャとGString展開
        colors.findAll { it?.active }.each { token ->
            println "Validated Color: ${token.name} -> Code: ${token.hex}"
        }
    }
}
