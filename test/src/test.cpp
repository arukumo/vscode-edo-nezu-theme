/**
 * C++: 20 構文解析検証テンプレート、名前空間、ポインタ/スマートポインタ、ラムダ式、プリプロセッサ、constexpr、例外処理の確認用
 */

#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <algorithm>
#include <concepts>

#define THEME_VERSION "1.0.0"

namespace EdoNezu::Core {

    // コンセプト定義
    template <typename T>
    concept Numeric = std::is_arithmetic_v<T>;

    struct RgbColor {
        uint8_t r{0};
        uint8_t g{0};
        uint8_t b{0};

        [[nodiscard]] constexpr double RelativeLuminance() const noexcept {
            return (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255.0;
        }
    };

    class ColorPalette {
    private:
        std::string m_name;
        RgbColor m_rgb;

    public:
        explicit ColorPalette(std::string name, RgbColor rgb)
            : m_name(std::move(name)), m_rgb(rgb) {}

        virtual ~ColorPalette() = default;

        void PrintDetails() const {
            std::cout << "Color: " << m_name
                      << " | Lum: " << m_rgb.RelativeLuminance() << std::endl;
        }
    };

} // namespace EdoNezu::Core

int main() {
    using namespace EdoNezu::Core;

    auto whiteNezu = std::make_unique<ColorPalette>("白鼠", RgbColor{220, 221, 221});
    auto masuhana  = std::make_unique<ColorPalette>("舛花色", RgbColor{86, 122, 152});

    std::vector<std::unique_ptr<ColorPalette>> paletteList;
    paletteList.push_back(std::move(whiteNezu));
    paletteList.push_back(std::move(masuhana));

    // ラムダ式による走査
    std::for_each(paletteList.begin(), paletteList.end(), [](const auto& item) {
        if (item) {
            item->PrintDetails();
        }
    });

    return 0;
}
