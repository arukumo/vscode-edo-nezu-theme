/**
 * JavaScript: オブジェクトの分割代入、アロー関数、Promise/async・await、正規表現、テンプレートリテラル、JSDocの確認用
 * @module EdoNezuTheme
 */

'use strict';

const THEME_CONFIG = Object.freeze({
  name: 'edo-nezu-theme',
  version: '1.0.0',
  isCalibrated: true
});

class ThemeValidator {
  #internalCode;

  constructor(code = '#567a98') {
    this.#internalCode = code;
  }

  // 非同期処理と正規表現
  async validateHexAsync(hex = this.#internalCode) {
    const hexPattern = /^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i;

    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const match = hex.match(hexPattern);
        if (!match) {
          reject(new Error(`Invalid color code: ${hex}`));
          return;
        }

        const [, r, g, b] = match.map(v => parseInt(v, 16));
        resolve({ r, g, b, formatted: `rgb(${r}, ${g}, ${b})` });
      }, 50);
    });
  }
}

// 分割代入と配列操作
const sampleColors = ['#dcdddd', '#567a98', '#cd8c5c'];
const [whiteNezu, masuhana] = sampleColors;

(async () => {
  const validator = new ThemeValidator(masuhana);
  try {
    const result = await validator.validateHexAsync();
    console.log(`検証完了: ${result.formatted}`);
  } catch (err) {
    console.error(`エラー発生: ${err.message}`);
  }
})();
