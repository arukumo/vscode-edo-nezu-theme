//
//  TestTheme.swift
//  江戸伝統色テーマ - Swift構文解析検証
//  プロトコル、オプショナルバインディング（guard let / if let）、クロージャ、プロパティラッパー、クロージャ引数短縮形（$0）の確認用
//

import Foundation

public protocol OpticalCalibratable {
    var relativeLuminance: Double { get }
    func isEyeFriendly() -> Bool
}

public enum ColorCategory: String, CaseIterable, Codable {
    case white = "白灰系"
    case blueNezu = "青鼠系"
    case teaBrown = "茶系"
}

public struct TraditionalColor: Identifiable, OpticalCalibratable {
    public let id: UUID = UUID()
    public let name: String
    public let hexCode: String
    public let category: ColorCategory

    public var relativeLuminance: Double {
        guard hexCode.hasPrefix("#"), hexCode.count == 7 else { return 0.0 }
        let scanner = Scanner(string: String(hexCode.dropFirst()))
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255.0
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255.0
            let b = Double(hexNumber & 0x0000ff) / 255.0
            return 0.2126 * r + 0.7152 * g + 0.0722 * b
        }
        return 0.0
    }

    public func isEyeFriendly() -> Bool {
        return relativeLuminance > 0.15 && relativeLuminance < 0.85
    }
}

// クロージャ・Higher-order Functions テスト
let sampleList = [
    TraditionalColor(name: "白鼠", hexCode: "#dcdddd", category: .white),
    TraditionalColor(name: "舛花色", hexCode: "#567a98", category: .blueNezu),
    TraditionalColor(name: "江戸茶", hexCode: "#cd8c5c", category: .teaBrown)
]

let output = sampleList
    .filter { $0.isEyeFriendly() }
    .sorted { $0.relativeLuminance > $1.relativeLuminance }
    .map { "\($0.name) (\($0.category.rawValue)): 輝度 \($0.relativeLuminance)" }

output.forEach { print($0) }
