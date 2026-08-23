/// Dart / Flutter 構文解析検証: Flutterウィジェット構文、Named Parameters、カスケード記法（..）、Null Safety（?, !）、Mixin、async/await の確認用
library edo_nezu_theme_test;

import 'dart:async';
import 'dart:convert';

// Mixin と抽象インターフェース
mixin OpticalFocusTracker {
  void logFocusShift(String tokenName) {
    print('[Focus] Checking optical depth for: $tokenName');
  }
}

enum ThemeState { uninitialized, active, calibrating }

class TraditionalColor with OpticalFocusTracker {
  final int id;
  final String name;
  final String hexCode;
  final bool isReceding;

  const TraditionalColor({
    required this.id,
    required this.name,
    required this.hexCode,
    this.isReceding = true,
  });

  // Null Safety と Getter
  int? get redChannel {
    if (!hexCode.startsWith('#') || hexCode.length != 7) return null;
    return int.tryParse(hexCode.substring(1, 3), radix: 16);
  }
}

// カスケード記法・非同期処理・アロー構文
Future<List<String>> processColorPalette(List<TraditionalColor> list) async {
  final buffer = StringBuffer()
    ..write('=== Palette Processing Started ===\n')
    ..write('Total Items: ${list.length}\n');

  print(buffer.toString());

  await Future.delayed(const Duration(milliseconds: 50));

  return list
      .where((c) => c.redChannel != null)
      .map((c) => '${c.name}: ${c.hexCode} (Receding: ${c.isReceding})')
      .toList();
}

void main() async {
  const whiteNezu = TraditionalColor(id: 1, name: '白鼠', hexCode: '#dcdddd');
  const masuhana = TraditionalColor(id: 2, name: '舛花色', hexCode: '#567a98');

  final results = await processColorPalette([whiteNezu, masuhana]);
  for (final line in results) {
    print(line);
  }
}
