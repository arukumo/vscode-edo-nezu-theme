/**
 * C: マクロ定義（#define）、構造体（struct）、列挙型（enum）、ポインタ演算、動的メモリ確保（malloc/free）、関数ポインタ、フォーマット指定子の確認用
 * @file test.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define THEME_NAME "edo-nezu-theme"
#define MAX_COLORS 8
#define CALC_LUMINANCE(r, g, b) (0.2126 * (r) + 0.7152 * (g) + 0.0722 * (b))

typedef enum {
    CATEGORY_WHITE = 0,
    CATEGORY_BLUE_NEZU,
    CATEGORY_BROWN_TEA
} ColorCategory;

typedef struct {
    int id;
    char name[32];
    char hex[8];
    unsigned char rgb[3];
    bool is_traditional;
} ColorToken;

/* 関数ポインタ型定義 */
typedef void (*ColorCallback)(const ColorToken*);

void print_color_info(const ColorToken* token) {
    if (token == NULL) return;

    double lum = CALC_LUMINANCE(token->rgb[0], token->rgb[1], token->rgb[2]);
    printf("[%02d] %s (%s) -> 輝度: %.2f\n",
           token->id, token->name, token->hex, lum);
}

int main(void) {
    /* 構造体ポインタと動的確保 */
    ColorToken* palette = (ColorToken*)malloc(sizeof(ColorToken) * 3);
    if (!palette) {
        perror("メモリ確保に失敗しました");
        return EXIT_FAILURE;
    }

    /* データ初期化（白鼠、舛花色、江戸茶） */
    palette[0] = (ColorToken){1, "白鼠", "#dcdddd", {220, 221, 221}, true};
    palette[1] = (ColorToken){2, "舛花色", "#567a98", {86, 122, 152}, true};
    palette[2] = (ColorToken){3, "江戸茶", "#cd8c5c", {205, 140, 92}, true};

    ColorCallback callback = print_color_info;

    printf("=== %s 構文検証 ===\n", THEME_NAME);
    for (size_t i = 0; i < 3; ++i) {
        callback(&palette[i]);
    }

    free(palette);
    palette = NULL;

    return EXIT_SUCCESS;
}
