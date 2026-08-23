// Java: アノテーション、ジェネリクス、Enum、Record、Stream API、ラムダ式、ラムダ参照の確認用
package com.edonezu.theme.test;

import java.io.Serializable;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 江戸伝統色テーマ構文解析テストクラス
 *
 * @author EdoNezu
 * @version 1.0.0
 */
public class Test<T extends CharSequence> implements Serializable {

    private static final long serialVersionUID = 1L;
    private static final double EYE_FATIGUE_THRESHOLD = 0.05;

    public enum ColorCategory {
        WHITE_BASE("白系"),
        BLUE_NEZU("青鼠系"),
        BROWN_TEA("茶系");

        private final String label;

        ColorCategory(String label) {
            this.label = label;
        }

        public String getLabel() {
            return label;
        }
    }

    // Java 16+ Record 構文テスト
    public record ColorToken(int id, String name, String hex, ColorCategory category) {
    }

    @SuppressWarnings("unchecked")
    public List<String> filterValidColors(List<ColorToken> tokens) {
        if (tokens == null || tokens.isEmpty()) {
            return Collections.emptyList();
        }

        // Stream API・ラムダ式・メソッド参照
        return tokens.stream()
                .filter(t -> t.id() > 0 && t.hex().startsWith("#"))
                .sorted(Comparator.comparing(ColorToken::name))
                .map(token -> {
                    String formatted = String.format("Color [%s]: %s (%s)",
                            token.category().getLabel(), token.name(), token.hex());
                    return formatted.toLowerCase(Locale.ROOT);
                })
                .collect(Collectors.toList());
    }

    public static void main(String[] args) {
        TestTheme<String> tester = new TestTheme<>();
        List<ColorToken> sampleTokens = Arrays.asList(
                new ColorToken(1, "白鼠", "#dcdddd", ColorCategory.WHITE_BASE),
                new ColorToken(2, "舛花色", "#567a98", ColorCategory.BLUE_NEZU),
                new ColorToken(3, "江戸茶", "#cd8c5c", ColorCategory.BROWN_TEA));

        List<String> results = tester.filterValidColors(sampleTokens);
        results.forEach(System.out::println);
    }
}
