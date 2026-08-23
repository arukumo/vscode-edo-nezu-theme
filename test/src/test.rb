# frozen_string_literal: true
# Ruby: シンボル（:symbol）、インスタンス変数（@var）、クラス変数（@@var）、ブロック/Proc/Lambda、モジュール（Mix-in）、正規表現、文字列補間（#{}）の確認用
module EdoNezu
  module OpticalCalculations
    # 相対輝度計算モジュール
    def relative_luminance(r, g, b)
      (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255.0
    end
  end

  class PaletteManager
    include OpticalCalculations

    THEME_NAME = 'edo-nezu-theme'
    @@instance_count = 0

    attr_reader :colors, :created_at

    def initialize
      @colors = []
      @created_at = Time.now
      @@instance_count += 1
    end

    # 色の登録（可変長引数とハッシュ）
    def add_color(id:, name:, hex:, category: :blue_nezu)
      color_data = {
        id: id,
        name: name,
        hex: hex,
        category: category,
        parsed_rgb: parse_hex(hex)
      }
      @colors << color_data
    end

    # ブロック付きメソッド
    def each_color
      return to_enum(:each_color) unless block_given?

      @colors.each do |c|
        yield c if c[:parsed_rgb]
      end
    end

    private

    def parse_hex(hex_str)
      # 正規表現とキャプチャ
      if hex_str =~ /\A#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})\z/i
        [Regexp.last_match(1).hex, Regexp.last_match(2).hex, Regexp.last_match(3).hex]
      end
    end
  end
end

# 実行・シンボルとラムダのテスト
manager = EdoNezu::PaletteManager.new
manager.add_color(id: 1, name: '白鼠', hex: '#dcdddd', category: :white)
manager.add_color(id: 2, name: '舛花色', hex: '#567a98', category: :blue_nezu)
manager.add_color(id: 3, name: '江戸茶', hex: '#cd8c5c', category: :tea_brown)

formatter = ->(c) { "Color: #{c[:name]} (#{c[:hex]}) - Cat: :#{c[:category]}" }

manager.each_color do |color|
  puts formatter.call(color)
end
